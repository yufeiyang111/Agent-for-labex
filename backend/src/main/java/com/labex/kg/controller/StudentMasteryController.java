package com.labex.kg.controller;

import com.labex.common.Result;
import com.labex.kg.dto.StudentMasteryDTO;
import com.labex.kg.service.StudentMasteryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

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

        try {
            masteryService.computeMastery(studentId, userId);
            StudentMasteryDTO dto = masteryService.getMastery(studentId);
            return Result.success(dto);
        } catch (Exception e) {
            log.warn("Load mastery failed for student {}: {}", studentId, e.getMessage());
            return Result.success(emptyMastery());
        }
    }

    /** Teacher view of a student's mastery */
    @GetMapping("/student/{studentId}")
    public Result<StudentMasteryDTO> studentState(@PathVariable int studentId) {
        try {
            masteryService.computeMastery(studentId, "Student " + studentId);
            StudentMasteryDTO dto = masteryService.getMastery(studentId);
            return Result.success(dto);
        } catch (Exception e) {
            log.warn("Load mastery failed for student {}: {}", studentId, e.getMessage());
            return Result.success(emptyMastery());
        }
    }

    private String getCurrentUserId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated()) {
            return auth.getName();
        }
        return "anonymous";
    }

    private StudentMasteryDTO emptyMastery() {
        StudentMasteryDTO dto = new StudentMasteryDTO();
        dto.setOverallMastery(0.5);
        dto.setWeakPoints(new ArrayList<>());
        dto.setStrongPoints(new ArrayList<>());
        dto.setRadarData(new ArrayList<>());
        return dto;
    }
}
