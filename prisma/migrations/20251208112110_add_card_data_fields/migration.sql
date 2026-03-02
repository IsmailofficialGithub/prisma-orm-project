/*
  Warnings:

  - You are about to alter the column `name` on the `card_acquisition_types` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(50)`.
  - You are about to alter the column `name` on the `cards` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(100)`.
  - A unique constraint covering the columns `[card_id_int]` on the table `cards` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `card_id_int` to the `cards` table without a default value. This is not possible if the table is not empty.
  - Added the required column `character_id` to the `cards` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."card_acquisition_types" ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "name" SET DATA TYPE VARCHAR(50);

-- AlterTable
ALTER TABLE "public"."cards" ADD COLUMN     "card_id_int" INTEGER NOT NULL,
ADD COLUMN     "character_id" INTEGER NOT NULL,
ADD COLUMN     "edition_id" INTEGER,
ALTER COLUMN "name" SET DATA TYPE VARCHAR(100);

-- CreateTable
CREATE TABLE "public"."card_edition_types" (
    "id" INTEGER NOT NULL DEFAULT 0,
    "name" VARCHAR(30) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "card_edition_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."card_characters" (
    "id" INTEGER NOT NULL DEFAULT 0,
    "name" VARCHAR(50) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "card_characters_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "card_edition_types_name_key" ON "public"."card_edition_types"("name");

-- CreateIndex
CREATE UNIQUE INDEX "card_characters_name_key" ON "public"."card_characters"("name");

-- CreateIndex
CREATE UNIQUE INDEX "cards_card_id_int_key" ON "public"."cards"("card_id_int");

-- AddForeignKey
ALTER TABLE "public"."cards" ADD CONSTRAINT "cards_edition_id_fkey" FOREIGN KEY ("edition_id") REFERENCES "public"."card_edition_types"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."cards" ADD CONSTRAINT "cards_character_id_fkey" FOREIGN KEY ("character_id") REFERENCES "public"."card_characters"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
