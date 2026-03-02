/*
  Warnings:

  - A unique constraint covering the columns `[google_id]` on the table `players` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "public"."players" ADD COLUMN     "google_id" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "players_google_id_key" ON "public"."players"("google_id");
