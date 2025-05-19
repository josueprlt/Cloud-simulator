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
        //  First user //
        $user  = new User();
        $user->setPseudo('Estelle Lacombe');
        $user->setEmail('estelle-lacombe@email.com');
        $hashedPassword = $this->passwordHasher->hashPassword(
            $user,
            'Test!este1'
        );
        $user->setPassword($hashedPassword);
        $manager->persist($user);

        //  Second user //
        $user  = new User();
        $user->setPseudo('Liane Trottier');
        $user->setEmail('liane-trottier@email.com');
        $hashedPassword = $this->passwordHasher->hashPassword(
            $user,
            'Test!este2'
        );
        $user->setPassword($hashedPassword);
        $manager->persist($user);

        $manager->flush();
    }
}
