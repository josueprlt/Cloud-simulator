<?php

namespace App\DataFixtures;

use App\Entity\User;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class UserFixtures extends Fixture
{
    public function __construct(
        private UserPasswordHasherInterface $passwordHasher
    ) {}

    public function load(ObjectManager $manager): void
    {
        // Utilisateurs de base
        $user1 = new User();
        $user1->setPseudo('Estelle Lacombe');
        $user1->setEmail('estelle-lacombe@email.com');
        $user1->setPassword($this->passwordHasher->hashPassword($user1, 'Test!este1'));
        $this->addReference('user_estelle', $user1);
        $manager->persist($user1);

        $user2 = new User();
        $user2->setPseudo('Liane Trottier');
        $user2->setEmail('liane-trottier@email.com');
        $user2->setPassword($this->passwordHasher->hashPassword($user2, 'Test!este2'));
        $this->addReference('user_liane', $user2);
        $manager->persist($user2);

        // 10 utilisateurs supplémentaires
        for ($i = 1; $i <= 10; $i++) {
            $user = new User();
            $user->setPseudo("User Test {$i}");
            $user->setEmail("user{$i}@test.com");
            $user->setPassword($this->passwordHasher->hashPassword($user, 'Test!user' . $i));
            $this->addReference("user_{$i}", $user);
            $manager->persist($user);
        }

        $manager->flush();
    }
}
