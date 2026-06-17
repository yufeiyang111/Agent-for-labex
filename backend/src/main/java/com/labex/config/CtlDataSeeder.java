package com.labex.config;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.entity.Clazz;
import com.labex.entity.Student;
import com.labex.entity.Teacher;
import com.labex.mapper.ClazzMapper;
import com.labex.mapper.StudentMapper;
import com.labex.mapper.TeacherMapper;
import com.labex.mapper.teaching.*;
import com.labex.entity.teaching.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;

/**
 * CTL 教学闭环种子数据 (CommandLineRunner)
 * 仅在 t_course 为空时执行，保证幂等。
 * 注入：1 教师 + 1 班级 + 25 学生 + 3 课程 + 3 毕业要求 + 9 指标点 +
 *       11 课程目标 + 14 支撑关系 + 3 教学大纲 + 35 章节 + 3 开课 +
 *       18 评分项 + 27 关联 + 18*25 分数 + 3 评价草稿
 */
@Component
@Slf4j
@Order(100)
public class CtlDataSeeder implements CommandLineRunner {

    @Autowired private TeacherMapper teacherMapper;
    @Autowired private ClazzMapper clazzMapper;
    @Autowired private StudentMapper studentMapper;
    @Autowired private CourseMapper courseMapper;
    @Autowired private GraduationRequirementMapper reqMapper;
    @Autowired private GraduationIndicatorMapper indMapper;
    @Autowired private CourseObjectiveMapper objMapper;
    @Autowired private ObjectiveSupportMapper supportMapper;
    @Autowired private SyllabusMapper syllabusMapper;
    @Autowired private SyllabusChapterMapper chapterMapper;
    @Autowired private CourseOfferingMapper offeringMapper;
    @Autowired private ScoringItemMapper itemMapper;
    @Autowired private ScoringItemObjectiveMapper itemObjMapper;
    @Autowired private ScoringScoreMapper scoreMapper;
    @Autowired private QualityEvaluationMapper evalMapper;
    @Autowired private PasswordEncoder passwordEncoder;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void run(String... args) {
        long count = courseMapper.selectCount(null);
        if (count > 0) {
            log.info("CtlDataSeeder: t_course 不为空 ({} 条)，跳过种子注入", count);
            return;
        }
        log.info("CtlDataSeeder: 开始注入 CTL 种子数据...");

        // 1) 教师
        Teacher teacher = saveTeacher("teacher01", "123456", "张老师", "TEACHER");

        // 2) 班级 + 学生
        Clazz clazz = saveClazz("SW2024-1", teacher.getTeacherId());
        List<Student> students = saveStudents(clazz.getNo(), 25);

        // 3) 毕业要求 + 指标点
        List<GraduationRequirement> reqs = saveRequirements();
        List<GraduationIndicator> inds = saveIndicators(reqs);

        // 4) 课程 + 大纲 + 章节 + 目标 + 支撑关系
        Course se = saveCourse("SE101", "软件工程", 4, 64, 32, 32, "计算机", teacher);
        Course db = saveCourse("DB201", "数据库原理", 3, 48, 32, 16, "计算机", teacher);
        Course web = saveCourse("WEB301", "Web前端开发", 2, 32, 16, 16, "计算机", teacher);

        // 课程目标 + 支撑关系
        List<CourseObjective> seObjs = saveObjectives(se.getCourseId(), new String[][]{
                {"knowledge", "掌握软件工程基础理论（需求、设计、编码、测试、维护）和生命周期模型。"},
                {"ability", "能运用 UML 完成中小型系统的分析与设计，编写规范的开发文档。"},
                {"quality", "树立工程化思维、团队协作意识和质量第一的职业素养。"}
        });
        List<CourseObjective> dbObjs = saveObjectives(db.getCourseId(), new String[][]{
                {"knowledge", "掌握关系数据库理论、SQL 语法、范式理论与事务并发控制机制。"},
                {"ability", "能根据业务需求进行概念/逻辑/物理建模，优化复杂 SQL。"},
                {"quality", "养成数据安全意识，理解规范化与性能之间的权衡。"}
        });
        List<CourseObjective> webObjs = saveObjectives(web.getCourseId(), new String[][]{
                {"knowledge", "掌握 HTML5/CSS3/JavaScript 核心 API 与现代前端工程化体系。"},
                {"ability", "能独立完成响应式 Web 页面，熟练使用 Vue 框架开发单页应用。"},
                {"quality", "形成良好的前端编码规范、用户体验意识与持续学习习惯。"}
        });

        // 支撑关系：每个目标 1-2 个指标点
        bindSupport(seObjs, inds, "5.1", "5.2");
        bindSupport(dbObjs, inds, "1.3", "5.1");
        bindSupport(webObjs, inds, "5.2", "1.3");

        // 5) 大纲 + 章节
        saveSyllabusAndChapters(se, "本课程系统讲授软件工程的概念、原理、方法与工具，通过项目驱动培养工程实践能力。",
                "本课程主要任务是让学生理解软件工程核心思想，掌握主流开发方法与团队协作流程，能在真实项目中应用所学。",
                "1.理解软件工程的发展历史与生命周期模型。\n2.掌握需求分析方法与 UML 建模。\n3.掌握软件设计与测试技术。\n4.熟悉项目管理与配置工具。",
                "1.能完成中小型系统的需求分析与建模。\n2.能根据设计原则进行架构设计。\n3.能使用主流工具完成编码与测试。",
                "通过项目实践，培养严谨的工程态度、团队沟通能力和持续改进的职业素养。",
                "采用课堂讲授+案例分析+项目驱动的混合教学方式。鼓励学生以小组形式完成贯穿学期的大作业，模拟真实项目开发流程。",
                "课后习题要求覆盖每章核心概念，每周提交 1 次作业，要求学生独立完成并标注参考文献，禁止抄袭。",
                "考核由平时作业（30%）、实验项目（30%）、期末综合项目（40%）三部分构成，全面评价学习效果。",
                "课程分目标达成度 = Σ(学生该项实际得分/该项满分 × 权重) / Σ(权重)；课程总目标达成度 = 达到课程期望分值的学生人数 / 学生总人数。"
        );
        saveSyllabusAndChapters(db, "本课程讲授关系数据库的核心理论与实践，涵盖 SQL、范式、事务、并发控制与性能优化。",
                "本课程主要任务是让学生系统掌握数据库的设计与使用方法，能独立完成数据库应用系统的开发。",
                "1.掌握关系模型理论与关系代数。\n2.熟练使用 SQL 完成数据查询与维护。\n3.理解范式理论与数据库设计方法。",
                "1.能根据业务需求完成 ER 图设计。\n2.能进行范式分解并优化查询性能。\n3.能使用 JDBC 或 ORM 框架访问数据库。",
                "通过实验与项目实践，养成严谨的数据思维、安全意识与规范化的开发习惯。",
                "理论讲授配合 MySQL 实验环境，边讲边练；课程项目要求学生独立完成一个小型业务系统。",
                "每章布置 3-5 道习题，涵盖 SQL 编写、ER 设计、范式判断等，要求按时提交并附详细分析。",
                "考核由平时作业（30%）、实验（30%）、期末机考（40%）三部分构成。",
                "课程分目标达成度 = Σ(学生该项实际得分/该项满分 × 权重) / Σ(权重)；课程总目标达成度 = 达到课程期望分值的学生人数 / 学生总人数。"
        );
        saveSyllabusAndChapters(web, "本课程讲授 Web 前端开发的核心技术与工程实践，涵盖 HTML5、CSS3、JavaScript 与 Vue 框架。",
                "本课程主要任务是让学生掌握现代 Web 前端开发技术栈，能独立完成响应式网页与单页应用。",
                "1.掌握 HTML5 语义化标签与表单。\n2.掌握 CSS3 布局、动画与响应式设计。\n3.掌握 JavaScript 核心语法与 DOM 操作。",
                "1.能使用 HTML5+CSS3 完成静态网页。\n2.能使用 JavaScript 实现交互逻辑。\n3.能使用 Vue 框架开发单页应用。",
                "通过项目实践，培养对前端用户体验的敏感度、良好的编码规范与团队协作精神。",
                "课堂讲授+实验并行，每讲完一个知识点立即进行动手练习；课程大作业要求学生完成一个完整的 SPA 项目。",
                "每章布置 2-3 道实操作业，要求提交代码与运行截图，附实现思路说明。",
                "考核由平时作业（30%）、实验（30%）、期末项目（40%）三部分构成。",
                "课程分目标达成度 = Σ(学生该项实际得分/该项满分 × 权重) / Σ(权重)；课程总目标达成度 = 达到课程期望分值的学生人数 / 学生总人数。"
        );

        // 6) 开课 + 评分项 + 关联
        CourseOffering seOff = saveOffering(se, teacher, clazz.getNo(), "2024-2025-1", 25);
        CourseOffering dbOff = saveOffering(db, teacher, clazz.getNo(), "2024-2025-1", 25);
        CourseOffering webOff = saveOffering(web, teacher, clazz.getNo(), "2024-2025-1", 25);

        saveScoringItems(seOff, seObjs, new String[]{
                "homework#作业1:需求分析#100#70#0.05",
                "homework#作业2:系统设计#100#70#0.05",
                "homework#作业3:详细设计#100#70#0.05",
                "homework#作业4:测试用例#100#70#0.05",
                "homework#作业5:项目总结#100#70#0.05",
                "experiment#实验1:UML建模#100#70#0.10",
                "experiment#实验2:单元测试#100#70#0.10",
                "experiment#实验3:集成测试#100#70#0.10",
                "project#项目:综合项目#100#70#0.50"
        });
        saveScoringItems(dbOff, dbObjs, new String[]{
                "homework#作业1:SQL基础#100#70#0.05",
                "homework#作业2:SQL高级#100#70#0.05",
                "homework#作业3:ER设计#100#70#0.05",
                "homework#作业4:范式分解#100#70#0.05",
                "homework#作业5:优化#100#70#0.05",
                "experiment#实验1:MySQL#100#70#0.10",
                "experiment#实验2:JDBC#100#70#0.10",
                "experiment#实验3:事务#100#70#0.10",
                "project#项目:课程设计#100#70#0.50"
        });
        saveScoringItems(webOff, webObjs, new String[]{
                "homework#作业1:HTML#100#70#0.05",
                "homework#作业2:CSS#100#70#0.05",
                "homework#作业3:JS#100#70#0.05",
                "homework#作业4:Vue基础#100#70#0.10",
                "homework#作业5:Vue组件#100#70#0.10",
                "experiment#实验1:响应式#100#70#0.10",
                "experiment#实验2:SPA#100#70#0.10",
                "project#项目:完整SPA#100#70#0.50"
        });

        // 7) 分数 (按学生 × 评分项 — 用相对成绩分布：90% 学生及格 60-95，10% 优秀 95+)
        saveScores(seOff.getOfferingId(), students, 60, 98);
        saveScores(dbOff.getOfferingId(), students, 55, 95);
        saveScores(webOff.getOfferingId(), students, 65, 99);

        // 8) 评价草稿
        saveEvalDraft(seOff, teacher);
        saveEvalDraft(dbOff, teacher);
        saveEvalDraft(webOff, teacher);

        log.info("CtlDataSeeder: 注入完成 — 教师 {} / 班级 {} / 学生 {} / 课程 {} / 开课 {} / 评分项 {}",
                1, 1, students.size(), 3, 3, itemMapper.selectCount(null));
    }

    // ============ Helpers ============

    private Teacher saveTeacher(String account, String pwd, String name, String role) {
        Teacher t = new Teacher();
        t.setTeacherAccount(account);
        t.setTeacherPassword(passwordEncoder.encode(pwd));
        t.setTeacherName(name);
        t.setRole(role);
        t.setState(1);
        teacherMapper.insert(t);
        return t;
    }

    private Clazz saveClazz(String no, Integer teacherId) {
        Clazz c = new Clazz();
        c.setNo(no);
        c.setMemo("软件工程 2024 级 1 班");
        c.setState(1);
        c.setTeacherId(teacherId);
        clazzMapper.insert(c);
        return c;
    }

    private List<Student> saveStudents(String clazzNo, int n) {
        List<Student> list = new ArrayList<>();
        String[] surnames = {"李", "王", "张", "刘", "陈", "杨", "赵", "黄", "周", "吴", "徐", "孙", "胡", "朱", "高"};
        String[] names = {"伟", "芳", "娜", "敏", "静", "丽", "强", "磊", "军", "洋", "勇", "艳", "杰", "娟", "涛"};
        Random r = new Random(42);
        for (int i = 1; i <= n; i++) {
            Student s = new Student();
            s.setStudentNo(String.format("2024%04d", i));
            s.setStudentName(surnames[r.nextInt(surnames.length)] + names[r.nextInt(names.length)]);
            s.setStudentPassword(passwordEncoder.encode("123456"));
            s.setClazzNo(clazzNo);
            s.setState(1);
            s.setErrorCount(0);
            studentMapper.insert(s);
            list.add(s);
        }
        return list;
    }

    private List<GraduationRequirement> saveRequirements() {
        String[][] data = {
                {"1", "工程知识", "掌握数学、自然科学、工程基础和专业知识，能用于解决复杂工程问题。"},
                {"2", "问题分析", "能应用数学、自然科学和工程科学的基本原理，识别、表达、并通过文献研究分析复杂工程问题。"},
                {"3", "设计/开发解决方案", "能设计针对复杂工程问题的解决方案，设计满足特定需求的系统、单元或工艺流程。"},
                {"4", "研究", "能基于科学原理并采用科学方法对复杂工程问题进行研究。"},
                {"5", "使用现代工具", "能针对复杂工程问题，开发、选择与使用恰当的技术、资源、现代工程工具和信息技术工具。"}
        };
        List<GraduationRequirement> list = new ArrayList<>();
        for (String[] d : data) {
            GraduationRequirement r = new GraduationRequirement();
            r.setCode(d[0]);
            r.setTitle(d[1]);
            r.setDescription(d[2]);
            reqMapper.insert(r);
            list.add(r);
        }
        return list;
    }

    private List<GraduationIndicator> saveIndicators(List<GraduationRequirement> reqs) {
        // 每个毕业要求 2 个指标点
        String[][] inds = {
                {"1.1", "能将数学、自然科学、工程科学的语言工具用于工程问题的表述。"},
                {"1.2", "能针对具体的对象建立数学模型并求解。"},
                {"1.3", "能结合专业背景，运用数学模型解决实际工程问题。"},
                {"2.1", "能识别和判断复杂工程问题的关键环节。"},
                {"2.2", "能基于相关科学原理和数学模型正确表达复杂工程问题。"},
                {"2.3", "能通过文献研究寻求可替代的解决方案。"},
                {"3.1", "掌握工程设计的基本方法与流程。"},
                {"3.2", "能根据需求完成系统方案设计。"},
                {"3.3", "能在设计中体现创新意识。"},
                {"4.1", "能基于科学原理对实验结果进行分析。"},
                {"4.2", "能采用科学方法对工程问题进行实验研究。"},
                {"4.3", "能对实验数据进行综合分析并得出有效结论。"},
                {"5.1", "理解软件工程专业常用现代工程工具的使用原理并能理解其局限性。"},
                {"5.2", "能选择与使用恰当的信息技术工具和资源。"},
                {"5.3", "能使用现代工具进行系统开发与测试。"}
        };
        List<GraduationIndicator> list = new ArrayList<>();
        Map<String, Integer> reqMap = new HashMap<>();
        for (GraduationRequirement r : reqs) reqMap.put(r.getCode(), r.getRequirementId());
        for (String[] d : inds) {
            GraduationIndicator i = new GraduationIndicator();
            String code = d[0];
            String reqCode = code.split("\\.")[0];
            i.setRequirementId(reqMap.get(reqCode));
            i.setCode(code);
            i.setDescription(d[1]);
            indMapper.insert(i);
            list.add(i);
        }
        return list;
    }

    private Course saveCourse(String code, String name, int credit, int hours, int theory, int lab,
                              String major, Teacher teacher) {
        Course c = new Course();
        c.setCode(code);
        c.setNameCn(name);
        c.setNameEn(name);
        c.setCredit(new BigDecimal(credit));
        c.setHours(hours);
        c.setTheoryHours(theory);
        c.setLabHours(lab);
        c.setMajor(major);
        c.setPrerequisite("无");
        c.setDepartment("计算机系");
        c.setIntro(name + " 是计算机专业核心课程。");
        c.setOwnerId(teacher.getTeacherId());
        courseMapper.insert(c);
        return c;
    }

    private List<CourseObjective> saveObjectives(Integer courseId, String[][] data) {
        List<CourseObjective> list = new ArrayList<>();
        for (int i = 0; i < data.length; i++) {
            CourseObjective o = new CourseObjective();
            o.setCourseId(courseId);
            o.setCode("课程目标" + (i + 1));
            o.setCategory(data[i][0]);
            o.setDescription(data[i][1]);
            o.setSortOrder(i);
            objMapper.insert(o);
            list.add(o);
        }
        return list;
    }

    private void bindSupport(List<CourseObjective> objs, List<GraduationIndicator> inds, String... indCodes) {
        Map<String, GraduationIndicator> indMap = new HashMap<>();
        for (GraduationIndicator i : inds) indMap.put(i.getCode(), i);
        for (int i = 0; i < objs.size() && i < indCodes.length; i++) {
            GraduationIndicator ind = indMap.get(indCodes[i]);
            if (ind == null) continue;
            ObjectiveSupport s = new ObjectiveSupport();
            s.setObjectiveId(objs.get(i).getObjectiveId());
            s.setIndicatorId(ind.getIndicatorId());
            s.setSupportStrength(1);
            supportMapper.insert(s);
        }
    }

    private void saveSyllabusAndChapters(Course course, String intro, String mainTask,
                                          String knowledge, String ability, String quality,
                                          String methods, String exercise, String assessment,
                                          String formula) {
        Syllabus s = new Syllabus();
        s.setCourseId(course.getCourseId());
        s.setCourseIntro(intro);
        s.setMainTask(mainTask);
        s.setKnowledgeGoals(knowledge);
        s.setAbilityGoals(ability);
        s.setQualityGoals(quality);
        s.setTeachingMethods(methods);
        s.setExerciseRequirements(exercise);
        s.setAssessmentMethods(assessment);
        s.setAchievementFormula(formula);
        s.setTextbooks("1. 经典教材《" + course.getNameCn() + "》（第 4 版），人民邮电出版社，2023 年。\n2. 配套实验指导书，校内自编，2024 年。");
        s.setReferencesList("1. 国际期刊《ACM Computing Surveys》近 3 年相关综述。\n2. 知名高校公开课（MIT/Stanford）相关视频资源。\n3. GitHub 开源项目 examples 仓库。");
        syllabusMapper.insert(s);

        // 章节：5 章
        String[][] chapters = chaptersFor(course.getNameCn());
        for (int i = 0; i < chapters.length; i++) {
            SyllabusChapter c = new SyllabusChapter();
            c.setSyllabusId(s.getSyllabusId());
            c.setChapterNo("第" + cnNum(i + 1) + "章");
            c.setTopic(chapters[i][0]);
            c.setKnowledgeRequirements(chapters[i][1]);
            c.setIdeologicalElements("融入工程伦理与工匠精神。");
            c.setRecommendedHours(Integer.parseInt(chapters[i][2]));
            c.setTeachingMethod(chapters[i][3]);
            c.setObjectiveRef("课程目标" + chapters[i][4]);
            c.setSortOrder(i);
            chapterMapper.insert(c);
        }
    }

    private String[][] chaptersFor(String name) {
        return new String[][]{
                {"概述与基础", "介绍本课程的研究对象、发展历史、核心概念与学习目标，建立整体认知框架。", "2", "讲授", "1"},
                {"核心理论与方法", "深入讲解核心理论、典型方法与适用场景，配合案例分析加深理解。", "6", "讲授", "1,2"},
                {"实践技能训练", "通过具体实践任务，掌握工具使用、问题求解与方案实施的全过程。", "8", "实验", "2"},
                {"综合项目实践", "小组协作完成贯穿项目，综合运用所学知识，培养工程实践能力。", "10", "实践", "2,3"},
                {"总结与拓展", "梳理全课程知识体系，展望前沿发展，布置期末考核任务。", "6", "讲授", "3"}
        };
    }

    private static String cnNum(int n) {
        return switch (n) {
            case 1 -> "一";
            case 2 -> "二";
            case 3 -> "三";
            case 4 -> "四";
            case 5 -> "五";
            case 6 -> "六";
            case 7 -> "七";
            case 8 -> "八";
            case 9 -> "九";
            case 10 -> "十";
            default -> String.valueOf(n);
        };
    }

    private CourseOffering saveOffering(Course course, Teacher teacher, String clazzNo, String semester, int n) {
        CourseOffering o = new CourseOffering();
        o.setCourseId(course.getCourseId());
        o.setClazzNo(clazzNo);
        o.setTeacherId(teacher.getTeacherId());
        o.setSemester(semester);
        o.setStudentCount(n);
        o.setStatus("open");
        offeringMapper.insert(o);
        return o;
    }

    private void saveScoringItems(CourseOffering off, List<CourseObjective> objs, String[] specs) {
        int order = 0;
        for (String spec : specs) {
            String[] parts = spec.split("#");
            ScoringItem it = new ScoringItem();
            it.setOfferingId(off.getOfferingId());
            it.setType(parts[0]);
            String nameAndMax = parts[1];
            int colon = nameAndMax.indexOf(':');
            it.setName(colon > 0 ? nameAndMax.substring(colon + 1) : nameAndMax);
            it.setMaxScore(Integer.parseInt(parts[2]));
            it.setPassingScore(Integer.parseInt(parts[3]));
            it.setWeight(new BigDecimal(parts[4]));
            it.setSortOrder(order++);
            itemMapper.insert(it);
            // 关联所有目标
            for (CourseObjective o : objs) {
                ScoringItemObjective link = new ScoringItemObjective();
                link.setItemId(it.getItemId());
                link.setObjectiveId(o.getObjectiveId());
                itemObjMapper.insert(link);
            }
        }
    }

    private void saveScores(Integer offeringId, List<Student> students, int min, int max) {
        List<ScoringItem> items = itemMapper.selectList(new LambdaQueryWrapper<ScoringItem>()
                .eq(ScoringItem::getOfferingId, offeringId));
        Random r = new Random(offeringId * 31L);
        for (Student s : students) {
            for (ScoringItem it : items) {
                ScoringScore sc = new ScoringScore();
                sc.setItemId(it.getItemId());
                sc.setStudentId(s.getStudentId());
                sc.setScore(new BigDecimal(min + r.nextInt(max - min + 1)));
                sc.setSource("seed");
                scoreMapper.insert(sc);
            }
        }
    }

    private void saveEvalDraft(CourseOffering off, Teacher teacher) {
        QualityEvaluation e = new QualityEvaluation();
        e.setOfferingId(off.getOfferingId());
        e.setEvaluatorId(teacher.getTeacherId());
        e.setEvalRound(off.getSemester() + "-Round1");
        e.setCourseResponsible(teacher.getTeacherName());
        e.setCourseMembers("[\"" + teacher.getTeacherName() + "\"]");
        e.setEvalGroupMembers("[\"王教授\",\"李教授\"]");
        e.setObjectiveIndicatorRationality("reasonable");
        e.setObjectiveContainsKaq("contain");
        e.setAchievementValues("[]");
        e.setExpectedRationality("reasonable");
        e.setAnalysisRationality("relatively");
        e.setImprovementRationality("reasonable");
        e.setStatus("draft");
        evalMapper.insert(e);
    }
}
