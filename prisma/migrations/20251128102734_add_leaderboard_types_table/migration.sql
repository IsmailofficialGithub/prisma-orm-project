-- CreateTable
CREATE TABLE "public"."leaderboard_types" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(25) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "leaderboard_types_pkey" PRIMARY KEY ("id")
);
