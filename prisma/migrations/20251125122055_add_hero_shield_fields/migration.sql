-- AlterTable
ALTER TABLE "public"."matches" 
ADD COLUMN     "p1_hero_has_shield" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "p2_hero_has_shield" BOOLEAN NOT NULL DEFAULT false;
