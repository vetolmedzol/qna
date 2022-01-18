SELECT answers.id, answers.title, answers.question_id, answers.rating, answers.user_id, answers.best
FROM answers
         LEFT OUTER JOIN attachments ON answers.id = attachable_id
WHERE answers.best IS FALSE AND attachments.attachable_type LIKE 'Answer'
ORDER BY rating DESC;
