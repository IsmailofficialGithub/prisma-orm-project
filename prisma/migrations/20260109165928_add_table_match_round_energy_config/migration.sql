/*
  Warnings:

  - You are about to drop the column `roundEnergies` on the `match_configs` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "public"."match_configs" 
DROP COLUMN "roundEnergies",
ADD COLUMN     "default_round_energy" INTEGER NOT NULL DEFAULT 1;

-- CreateTable
CREATE TABLE "public"."match_round_energy_config" (
    "id" SERIAL NOT NULL,
    "round" INTEGER NOT NULL,
    "energy_t1" INTEGER NOT NULL DEFAULT 1,
    "energy_t2" INTEGER NOT NULL DEFAULT 1,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "match_round_energy_config_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "match_round_energy_config_round_key" ON "public"."match_round_energy_config"("round");
