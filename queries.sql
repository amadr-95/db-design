SELECT * FROM user_profile;
SELECT * FROM youtube_account;
SELECT * FROM youtube_channel;
SELECT * FROM channel_subscriber;

-- show all people whether they have a yt_account or not
SELECT first_name, last_name, email, youtube_account.created_at AS yt_account_date
FROM user_profile
LEFT JOIN youtube_account ON user_profile.id = youtube_account.id;

--show people who do not have a yt_account
SELECT first_name, last_name, email
FROM user_profile
LEFT JOIN youtube_account ON user_profile.id = youtube_account.id
WHERE youtube_account.created_at IS NULL;

SELECT COUNT(*) AS "people without yt_account"
FROM user_profile
LEFT JOIN youtube_account ON user_profile.id = youtube_account.id
WHERE youtube_account.created_at IS NULL;

-- show the channels which belongs to each person
SELECT first_name, last_name, email, channel_name FROM user_profile
LEFT JOIN youtube_account ON user_profile.id = youtube_account.id
LEFT JOIN youtube_channel ON youtube_account.id = youtube_channel.youtube_account_id;

-- count the number of channel which every person has
SELECT first_name, last_name, email, COUNT(youtube_channel.id) AS "number of channels"
FROM user_profile
LEFT JOIN youtube_account ON user_profile.id = youtube_account.id
LEFT JOIN youtube_channel ON youtube_account.id = youtube_channel.youtube_account_id
GROUP BY first_name, last_name, email;

-- count the number of subscribers that every channel has
SELECT channel_name, COUNT(youtube_channel_id) AS subscribers FROM youtube_channel
LEFT JOIN channel_subscriber ON youtube_channel.id = channel_subscriber.youtube_channel_id
GROUP BY channel_name;

SELECT first_name, last_name, email,  channel_name, COUNT(youtube_channel_id) AS susbcribers
FROM user_profile
LEFT JOIN youtube_account ON user_profile.id = youtube_account.id
LEFT JOIN youtube_channel ON youtube_account.id = youtube_channel.youtube_account_id
LEFT JOIN channel_subscriber ON youtube_channel.id = channel_subscriber.youtube_channel_id
GROUP BY first_name, last_name, email, channel_name;

--count the number of subscribers that every person has including all their channels
SELECT
    first_name,
    last_name,
    email,
    COUNT(DISTINCT youtube_channel.id) AS "number of channels",
    COUNT(DISTINCT channel_subscriber.youtube_account_id) AS subscribers
FROM
    user_profile
LEFT JOIN youtube_account ON user_profile.id = youtube_account.id
LEFT JOIN youtube_channel ON youtube_account.id = youtube_channel.youtube_account_id
LEFT JOIN channel_subscriber ON youtube_channel.id = channel_subscriber.youtube_channel_id
GROUP BY
    first_name,
    last_name,
    email;

