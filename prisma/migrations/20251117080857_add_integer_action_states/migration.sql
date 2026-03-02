-- AlterTable
ALTER TABLE "public"."matches" ADD COLUMN     "p1ActionState" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "p2ActionState" INTEGER NOT NULL DEFAULT 0;
