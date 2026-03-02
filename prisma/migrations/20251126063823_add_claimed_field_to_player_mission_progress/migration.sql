-- AlterTable
ALTER TABLE "public"."mission_types" ALTER COLUMN "name" SET DATA TYPE VARCHAR(25);

-- AlterTable
ALTER TABLE "public"."player_missions_progress" ADD COLUMN     "claimed" BOOLEAN NOT NULL DEFAULT false;
