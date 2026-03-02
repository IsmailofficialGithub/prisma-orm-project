-- CreateTable
CREATE TABLE "public"."mission_types" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(10) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "mission_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."missions" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(30) NOT NULL,
    "required_progress" INTEGER NOT NULL,
    "lc_reward" SMALLINT NOT NULL,
    "xp_reward" SMALLINT NOT NULL,
    "mission_type_id" SMALLINT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "missions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."player_missions_progress" (
    "player_id" TEXT NOT NULL,
    "mission_id" INTEGER NOT NULL,
    "progress" INTEGER NOT NULL,
    "completed" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "player_missions_progress_pkey" PRIMARY KEY ("player_id","mission_id")
);

-- AddForeignKey
ALTER TABLE "public"."missions" ADD CONSTRAINT "missions_mission_type_id_fkey" FOREIGN KEY ("mission_type_id") REFERENCES "public"."mission_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_missions_progress" ADD CONSTRAINT "player_missions_progress_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "public"."players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_missions_progress" ADD CONSTRAINT "player_missions_progress_mission_id_fkey" FOREIGN KEY ("mission_id") REFERENCES "public"."missions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
