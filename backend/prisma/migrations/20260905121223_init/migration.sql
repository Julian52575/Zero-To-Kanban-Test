-- CreateTable
CREATE TABLE "todo_items" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "completed" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "todo_items_pkey" PRIMARY KEY ("id")
);
