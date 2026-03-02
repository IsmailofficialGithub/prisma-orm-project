-- AlterTable
ALTER TABLE "public"."matches" ADD COLUMN     "playerSkippedTurn" BOOLEAN NOT NULL DEFAULT false,
ALTER COLUMN "currentPlayerTurn" DROP DEFAULT;
