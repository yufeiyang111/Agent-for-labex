package com.labex.kg.controller;

import com.labex.common.Result;
import com.labex.kg.dto.StudentMasteryDTO;
import com.labex.kg.service.StudentMasteryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/mastery")
public class StudentMasteryController {

    @Autowired
    private StudentMasteryService masteryService;

    /** Get current student's mastery profile */
    @GetMapping("/my-state")
    public Result<StudentMasteryDTO> myState() {
        String userId = getCurrentUserId();
        int studentId;
        try {
            studentId = Integer.parseInt(userId);
        } catch (NumberFormatException e) {
            return Result.error("Invalid user ID");
        }

        // Trigger refresh on demand
        masteryService.computeMastery(studentId, userId);
        StudentMasteryDTO dto = masteryService.getMastery(studentId);
        return Result.success(dto);
    }

    /** Teacher view of a student's mastery */
    @GetMapping("/student/{studentId}")
    public Result<StudentMasteryDTO> studentState(@PathVariable int studentId) {
        masteryService.computeMastery(studentId, "Student " + studentId);
        StudentMasteryDTO dto = masteryService.getMastery(studentId);
        return Result.success(dto);
    }

    private String getCurrentUserId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated()) {
            return auth.getName();
        }
        return "anonymous";
    }
}
