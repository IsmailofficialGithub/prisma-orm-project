-- AlterTable
ALTER TABLE "public"."missions" ADD COLUMN     "mission_image_type_id" SMALLINT NOT NULL,
ALTER COLUMN "lc_reward" SET DATA TYPE INTEGER,
ALTER COLUMN "xp_reward" SET DATA TYPE INTEGER;

-- CreateTable
CREATE TABLE "public"."mission_image_types" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(10) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "mission_image_types_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."missions" ADD CONSTRAINT "missions_mission_image_type_id_fkey" FOREIGN KEY ("mission_image_type_id") REFERENCES "public"."mission_image_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
