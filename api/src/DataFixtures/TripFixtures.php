<?php

namespace App\DataFixtures;

use App\Entity\Trip;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class TripFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        $trip  = new Trip();

        $trip->setTitle('Trip 1');
        $trip->setDescription('Desc of the trip 1');
        $trip->setStartAt(new \DateTime('2023-10-01'));
        $trip->setEndAt(new \DateTime('2023-10-10'));

        $manager->persist($trip);

        $manager->flush();
    }
}
