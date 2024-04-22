-- USER_PROFILE TABLE
CREATE TABLE IF NOT EXISTS user_profile(
    id BIGSERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL,
    gender TEXT NOT NULL,
    create_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

--adding constraints
ALTER TABLE user_profile 
ADD CONSTRAINT email_unique UNIQUE(email);

ALTER TABLE user_profile 
ADD CONSTRAINT gender_check CHECK(gender IN ('MALE', 'FEMALE'));
-- ----------------------------------

--YOUTUBE_ACCOUNT TABLE (1 to 1 RELATIONSHIP WITH USER_PROFILE)
CREATE TABLE IF NOT EXISTS youtube_account(
    id BIGINT PRIMARY KEY,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

--adding constraints
ALTER TABLE youtube_account 
ADD FOREIGN KEY(id) REFERENCES user_profile(id);
-- ----------------------------------

--YOUTUBE_CHANNEL TABLE (1 to MANY RELATIONSHIP WHIT YOUTUBE_ACCOUNT)
CREATE TABLE IF NOT EXISTS youtube_channel(
    id BIGSERIAL PRIMARY KEY,
    youtube_account_id BIGINT NOT NULL,
    channel_name TEXT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

--adding constraints
ALTER TABLE youtube_channel
ADD FOREIGN KEY(youtube_account_id) REFERENCES youtube_account(id);

ALTER TABLE youtube_channel
ADD CONSTRAINT channel_name_unique UNIQUE(channel_name);
-- ----------------------------------

--CHANNEL_SUBSCRIBER TABLE (MANY to MANY RELATIONSHIP)
-- Link / bridge table
CREATE TABLE IF NOT EXISTS channel_subscriber (
    youtube_account_id BIGINT,
    youtube_channel_id BIGINT,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

--adding constraint
ALTER TABLE channel_subscriber
ADD PRIMARY KEY (youtube_account_id, youtube_channel_id); --composite key

-- ----------------------------------
-- Inserting data into user_profile table
INSERT INTO user_profile (first_name, last_name, email, gender, created_at)
VALUES ('John', 'Doe', 'john.doe@example.com', 'MALE', CURRENT_TIMESTAMP);

INSERT INTO user_profile (first_name, last_name, email, gender, created_at)
VALUES ('Jane', 'Smith', 'jane.smith@example.com', 'FEMALE', CURRENT_TIMESTAMP);

INSERT INTO user_profile (first_name, last_name, email, gender, created_at)
VALUES ('Nelson', 'James', 'nelson.james@example.com', 'MALE', CURRENT_TIMESTAMP);

INSERT INTO user_profile (first_name, last_name, email, gender, created_at)
VALUES ('Mariam', 'Ali', 'mariam.ali@example.com', 'FEMALE', CURRENT_TIMESTAMP);

-- Inserting data into youtube_account table
INSERT INTO youtube_account (id, created_at)
VALUES (1, CURRENT_TIMESTAMP);

INSERT INTO youtube_account (id, created_at)
VALUES (2, CURRENT_TIMESTAMP);

INSERT INTO youtube_account (id, created_at)
VALUES (4, CURRENT_TIMESTAMP);

-- Inserting data into youtube_channel table
INSERT INTO youtube_channel (youtube_account_id, channel_name, created_at)
VALUES (1, 'JohnDoeChannel', CURRENT_TIMESTAMP);

INSERT INTO youtube_channel (youtube_account_id, channel_name, created_at)
VALUES (1, 'JohnsGaming', CURRENT_TIMESTAMP);

INSERT INTO youtube_channel (youtube_account_id, channel_name, created_at)
VALUES (2, 'JaneSmithVlogs', CURRENT_TIMESTAMP);

INSERT INTO youtube_channel (youtube_account_id, channel_name, created_at)
VALUES (4, 'MariamTutorials', CURRENT_TIMESTAMP);

-- Inserting data into channel_subscriber table
INSERT INTO channel_subscriber (youtube_account_id, youtube_channel_id, created_at)
VALUES (1, 3, CURRENT_TIMESTAMP); -- John subscribing to Jane's channel

INSERT INTO channel_subscriber (youtube_account_id, youtube_channel_id, created_at)
VALUES (1, 2, CURRENT_TIMESTAMP); -- Jane subscribing to John's gaming channel

INSERT INTO channel_subscriber (youtube_account_id, youtube_channel_id, created_at)
VALUES (4, 1, CURRENT_TIMESTAMP); -- Mariam subscribing to John's personal channel

INSERT INTO channel_subscriber (youtube_account_id, youtube_channel_id, created_at)
VALUES (2, 1, CURRENT_TIMESTAMP); -- Jane subscribing to John's personal channel

-- Mariam channel has 0 subscriptions

-- queries.sql script