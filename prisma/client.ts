import { PrismaClient } from '@prisma/client';
import chalk from 'chalk';

const prisma = new PrismaClient({
  log: ['info', { emit: 'event', level: 'query' }, 'warn', 'error'],
});

prisma.$on('query', (event) => {
  console.log(
    chalk.blue('prisma:query'),
    event.query,
    event.params !== '[]' ? `-- ${event.params}` : ''
  );
});

export default prisma;
