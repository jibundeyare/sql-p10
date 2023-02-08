-- union de tous les students qui font du JS ou du PHP
-- JS: tag.id 3
-- PHP: tag.id 5
SELECT student.*, tag.*
FROM student
INNER JOIN student_tag ON student.id = student_tag.student_id
INNER JOIN tag ON tag.id = student_tag.tag_id
WHERE tag.id = 3 OR tag.id = 5
ORDER BY student.id, tag.id;

-- tous les students qui font du JS et du PHP
SELECT student.*, tag.*
FROM student
INNER JOIN student_tag ON student.id = student_tag.student_id
INNER JOIN tag ON tag.id = student_tag.tag_id
WHERE student.id IN (
    -- tous les students qui font du JS
    -- JS: tag.id 3
    SELECT student.id
    FROM student
    INNER JOIN student_tag ON student.id = student_tag.student_id
    INNER JOIN tag ON tag.id = student_tag.tag_id
    WHERE tag.id = 3
)
AND student.id IN (
    -- tous les students qui font du PHP
    -- PHP: tag.id 5
    SELECT student.id
    FROM student
    INNER JOIN student_tag ON student.id = student_tag.student_id
    INNER JOIN tag ON tag.id = student_tag.tag_id
    WHERE tag.id = 5
)
ORDER BY student.id, tag.id

-- tous les students qui sont dans les deux sous-ensembles
-- variante avec INTERSECT
(
    -- tous les students qui font du JS
    -- JS: tag.id 3
    SELECT student.*
    FROM student
    INNER JOIN student_tag ON student.id = student_tag.student_id
    INNER JOIN tag ON tag.id = student_tag.tag_id
    WHERE tag.id = 3
)
INTERSECT
(
    -- tous les students qui font du PHP
    -- PHP: tag.id 5
    SELECT student.*
    FROM student
    INNER JOIN student_tag ON student.id = student_tag.student_id
    INNER JOIN tag ON tag.id = student_tag.tag_id
    WHERE tag.id = 5
)

-- tous les students qui font du JS à l'exclusion de ceux qui font du PHP
SELECT student.*, tag.*
FROM student
INNER JOIN student_tag ON student.id = student_tag.student_id
INNER JOIN tag ON tag.id = student_tag.tag_id
WHERE student.id IN (
    -- tous les students qui font du JS
    -- JS: tag.id 3
    SELECT student.id
    FROM student
    INNER JOIN student_tag ON student.id = student_tag.student_id
    INNER JOIN tag ON tag.id = student_tag.tag_id
    WHERE tag.id = 3
)
AND student.id NOT IN (
    -- tous les students qui font du PHP
    -- PHP: tag.id 5
    SELECT student.id
    FROM student
    INNER JOIN student_tag ON student.id = student_tag.student_id
    INNER JOIN tag ON tag.id = student_tag.tag_id
    WHERE tag.id = 5
)
ORDER BY student.id, tag.id

-- tous les students qui font du JS à l'exclusion de ceux qui font du PHP
-- variante avec EXCEPT
(
    -- tous les students qui font du JS
    -- JS: tag.id 3
    SELECT student.*
    FROM student
    INNER JOIN student_tag ON student.id = student_tag.student_id
    INNER JOIN tag ON tag.id = student_tag.tag_id
    WHERE tag.id = 3
)
EXCEPT
(
    -- tous les students qui font du PHP
    -- PHP: tag.id 5
    SELECT student.*
    FROM student
    INNER JOIN student_tag ON student.id = student_tag.student_id
    INNER JOIN tag ON tag.id = student_tag.tag_id
    WHERE tag.id = 5
)

-- tous les students qui font du PHP à l'exclusion de ceux qui font du JS
-- variante avec EXCEPT
(
    -- tous les students qui font du PHP
    -- PHP: tag.id 5
    SELECT student.*
    FROM student
    INNER JOIN student_tag ON student.id = student_tag.student_id
    INNER JOIN tag ON tag.id = student_tag.tag_id
    WHERE tag.id = 5
)
EXCEPT
(
    -- tous les students qui font du JS
    -- JS: tag.id 3
    SELECT student.*
    FROM student
    INNER JOIN student_tag ON student.id = student_tag.student_id
    INNER JOIN tag ON tag.id = student_tag.tag_id
    WHERE tag.id = 3
)

-- tous les students qui font du JS ou du PHP mais pas les deux
-- ATTENTION : nécessite avec mariadb >= 10.4.0 (à cause des parenthèses et EXCEPT)
SELECT *
FROM student
INNER JOIN student_tag ON student.id = student_tag.student_id
INNER JOIN tag ON tag.id = student_tag.tag_id
WHERE student.id IN (
    -- tous les students qui font du JS à l'exclusion de ceux qui font du PHP
    (
        -- tous les students qui font du JS
        -- JS: tag.id 3
        SELECT student.id
        FROM student
        INNER JOIN student_tag ON student.id = student_tag.student_id
        INNER JOIN tag ON tag.id = student_tag.tag_id
        WHERE tag.id = 3
    )
    EXCEPT
    (
        -- tous les students qui font du PHP
        -- PHP: tag.id 5
        SELECT student.id
        FROM student
        INNER JOIN student_tag ON student.id = student_tag.student_id
        INNER JOIN tag ON tag.id = student_tag.tag_id
        WHERE tag.id = 5
    )
    UNION
    -- tous les students qui font du PHP à l'exclusion de ceux qui font du JS
    (
        -- tous les students qui font du PHP
        -- PHP: tag.id 5
        SELECT student.id
        FROM student
        INNER JOIN student_tag ON student.id = student_tag.student_id
        INNER JOIN tag ON tag.id = student_tag.tag_id
        WHERE tag.id = 5
    )
    EXCEPT
    (
        -- tous les students qui font du JS
        -- JS: tag.id 3
        SELECT student.id
        FROM student
        INNER JOIN student_tag ON student.id = student_tag.student_id
        INNER JOIN tag ON tag.id = student_tag.tag_id
        WHERE tag.id = 3
    )
)
ORDER BY student.id, tag.id;

-- tous les students qui font du JS ou du PHP mais pas les deux
-- INFO : fonctionne aussi avec mariadb < 10.4.0
SELECT student.*, tag.*
FROM student
INNER JOIN student_tag ON student.id = student_tag.student_id
INNER JOIN tag ON tag.id = student_tag.tag_id
WHERE student.id IN (
    -- tous les students qui font du JS à l'exclusion de ceux qui font du PHP
    SELECT student.id
    FROM student
    WHERE student.id IN (
        -- tous les students qui font du JS
        -- JS: tag.id 3
        SELECT student.id
        FROM student
        INNER JOIN student_tag ON student.id = student_tag.student_id
        INNER JOIN tag ON tag.id = student_tag.tag_id
        WHERE tag.id = 3
    )
    AND student.id NOT IN (
        -- tous les students qui font du PHP
        -- PHP: tag.id 5
        SELECT student.id
        FROM student
        INNER JOIN student_tag ON student.id = student_tag.student_id
        INNER JOIN tag ON tag.id = student_tag.tag_id
        WHERE tag.id = 5
    )
)
OR student.id IN (
    -- tous les students qui font du PHP à l'exclusion de ceux qui font du JS
    SELECT student.id
    FROM student
    WHERE student.id IN (
        -- tous les students qui font du PHP
        -- PHP: tag.id 5
        SELECT student.id
        FROM student
        INNER JOIN student_tag ON student.id = student_tag.student_id
        INNER JOIN tag ON tag.id = student_tag.tag_id
        WHERE tag.id = 5
    )
    AND student.id NOT IN (
        -- tous les students qui font du JS
        -- JS: tag.id 3
        SELECT student.id
        FROM student
        INNER JOIN student_tag ON student.id = student_tag.student_id
        INNER JOIN tag ON tag.id = student_tag.tag_id
        WHERE tag.id = 3
    )
)
ORDER BY student.id, tag.id;
