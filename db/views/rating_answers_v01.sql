SELECT answers.id,
       answers.title,
       answers.question_id,
       answers.rating,
       answers.user_id,
       answers.best,
       ARRAY(SELECT attachments.id) AS attachments_ids
FROM answers
         LEFT OUTER JOIN attachments ON answers.id = attachable_id
WHERE answers.best IS FALSE
ORDER BY rating DESC;
