/*
  Warnings:

  - A unique constraint covering the columns `[idempotencyKey]` on the table `payment_intents` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "public"."payment_intents" ADD COLUMN     "idempotencyKey" VARCHAR(255);

-- CreateIndex
CREATE UNIQUE INDEX "payment_intents_idempotencyKey_key" ON "public"."payment_intents"("idempotencyKey");
