-- AlterTable
ALTER TABLE "public"."players" ADD COLUMN     "topCards" TEXT[] DEFAULT ARRAY[]::TEXT[];
