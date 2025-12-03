import { prisma } from "./repository/db.ts";

async function main(){
    const f = await prisma.flight.findFirst({ orderBy: { departureTime: 'desc' } });
    if(!f){
        console.log('NO_FLIGHT_FOUND');
        return;
    }
    console.log(f.id);
    await prisma.$disconnect();
}

main();
