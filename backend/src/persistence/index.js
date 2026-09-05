const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

async function init() {
    await prisma.$connect();
    console.log('Connected to database via Prisma');
}

async function teardown() {
    await prisma.$disconnect();
}

async function getItems() {
    return prisma.todoItem.findMany();
}

async function getItem(id) {
    return prisma.todoItem.findUnique({ where: { id } });
}

async function storeItem(item) {
    await prisma.todoItem.create({
        data: { id: item.id, name: item.name, completed: item.completed },
    });
}

async function updateItem(id, item) {
    await prisma.todoItem.update({
        where: { id },
        data: { name: item.name, completed: item.completed },
    });
}

async function removeItem(id) {
    await prisma.todoItem.delete({ where: { id } });
}

module.exports = {
    init,
    teardown,
    getItems,
    getItem,
    storeItem,
    updateItem,
    removeItem,
};
