/*
  Warnings:

  - You are about to drop the `Mission` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."Mission" DROP CONSTRAINT "Mission_mission_image_type_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."Mission" DROP CONSTRAINT "Mission_mission_type_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."Mission" DROP CONSTRAINT "Mission_reward_package_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."player_missions_progress" DROP CONSTRAINT "player_missions_progress_mission_id_fkey";

-- DropTable
DROP TABLE "public"."Mission";

-- CreateTable
CREATE TABLE "public"."missions" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(30) NOT NULL,
    "required_progress" INTEGER NOT NULL,
    "mission_type_id" SMALLINT NOT NULL,
    "mission_image_type_id" SMALLINT NOT NULL,
    "reward_package_id" UUID NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "missions_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."missions" ADD CONSTRAINT "missions_mission_type_id_fkey" FOREIGN KEY ("mission_type_id") REFERENCES "public"."mission_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."missions" ADD CONSTRAINT "missions_mission_image_type_id_fkey" FOREIGN KEY ("mission_image_type_id") REFERENCES "public"."mission_image_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."missions" ADD CONSTRAINT "missions_reward_package_id_fkey" FOREIGN KEY ("reward_package_id") REFERENCES "public"."reward_package"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_missions_progress" ADD CONSTRAINT "player_missions_progress_mission_id_fkey" FOREIGN KEY ("mission_id") REFERENCES "public"."missions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
