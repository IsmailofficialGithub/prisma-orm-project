-- CreateTable
CREATE TABLE "public"."match_configs" (
    "id" SERIAL NOT NULL,
    "maxDeckCardsCount" INTEGER NOT NULL DEFAULT 10,
    "maxHandCount" INTEGER NOT NULL DEFAULT 3,
    "maxSlotCount" INTEGER NOT NULL DEFAULT 5,
    "roundEnergies" JSONB NOT NULL,
    "turnTimer" INTEGER NOT NULL DEFAULT 30,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "match_configs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."match_preparations" (
    "id" TEXT NOT NULL,
    "configId" INTEGER NOT NULL,
    "playerId" TEXT NOT NULL,
    "aiPlayerId" TEXT NOT NULL,
    "firstTurn" TEXT NOT NULL,
    "playerFaction" INTEGER NOT NULL,
    "aiFaction" INTEGER NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'prepared',
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "match_preparations_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."match_preparations" ADD CONSTRAINT "match_preparations_configId_fkey" FOREIGN KEY ("configId") REFERENCES "public"."match_configs"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_preparations" ADD CONSTRAINT "match_preparations_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
