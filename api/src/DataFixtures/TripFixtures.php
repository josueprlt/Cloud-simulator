<?php

namespace App\DataFixtures;

use App\Entity\Trip;
use App\Entity\User;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Doctrine\Common\DataFixtures\DependentFixtureInterface;

class TripFixtures extends Fixture implements DependentFixtureInterface
{
    public function load(ObjectManager $manager): void
    {
        $user1 = $this->getReference('user_estelle');
        $user2 = $this->getReference('user_liane');
        $allUsers = [$user1, $user2];

        // Récupère les 10 autres utilisateurs
        for ($i = 1; $i <= 10; $i++) {
            $allUsers[] = $this->getReference("user_{$i}");
        }

        $voyageCount = 0;

        foreach ([$user1, $user2] as $user) {
            for ($i = 1; $i <= 5; $i++) {
                $trip = new Trip();
                $trip->setTitle("Voyage {$i} de " . $user->getPseudo());
                $trip->setDescription("Description du voyage {$i}.");
                $trip->setStartAt(new \DateTime("2023-10-0" . $i));
                $trip->setEndAt(new \DateTime("2023-10-" . (10 + $i)));
                $trip->setThumbnail("https://i.postimg.cc/T1Vjc2h0/trip.jpg");
                $trip->setIsArchive(false);
                $trip->addUser($user);

                // Ajout aléatoire de membres au voyage
                $members = $this->getRandomUsers($allUsers, rand(2, 6), [$user]);
                foreach ($members as $member) {
                    $trip->addUser($member);
                }

                $manager->persist($trip);
                $voyageCount++;
            }
        }

        $manager->flush();
    }

    private function getRandomUsers(array $users, int $count, array $exclude = []): array
    {
        $filtered = array_filter($users, fn($u) => !in_array($u, $exclude, true));
        shuffle($filtered);
        return array_slice($filtered, 0, min($count, count($filtered)));
    }

    public function getDependencies(): array
    {
        return [
            UserFixtures::class,
        ];
    }
}
