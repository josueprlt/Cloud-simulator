<?php

namespace App\DataFixtures;

use App\Entity\Voyage;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class VoyageFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        $voyage  = new Voyage();

        $voyage->setTitle('voyage fixture 1');
        $voyage->setStartAt(new \DateTime('2023-10-01'));
        $voyage->setEndAt(new \DateTime('2023-10-10'));

        $manager->persist($voyage);


        $manager->flush();
    }
}
