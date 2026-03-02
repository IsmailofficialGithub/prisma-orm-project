-- AlterTable
ALTER TABLE "public"."lootboxes" ADD COLUMN     "cost" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "description" VARCHAR(100);
