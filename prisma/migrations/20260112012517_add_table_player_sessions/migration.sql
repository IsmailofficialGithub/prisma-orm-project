-- CreateTable
CREATE TABLE "public"."player_sessions" (
    "id" VARCHAR(36) NOT NULL,
    "player_id" VARCHAR(36),
    "socket_id" VARCHAR(64) NOT NULL,
    "session_started_at" TIMESTAMPTZ(6),
    "session_ended_at" TIMESTAMPTZ(6),
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "player_sessions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "player_sessions_socket_id_key" ON "public"."player_sessions"("socket_id");
