<?php

namespace App\DataFixtures;

use App\Entity\Accomodation;
use App\Entity\Activity;
use App\Entity\Expense;
use App\Enum\AccomodationType;
use App\Enum\ExpenseType;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class ExpenseFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
         $expenseActivity = new Expense();
         $expenseActivity->setTitle('Dépense1')
                ->setCost(40)
                ->setType(ExpenseType::ACTIVITY)
                ->setPicture('imagecool');

         $expenseAccomodation = new Expense();
         $expenseAccomodation->setTitle('Dépense2')
            ->setCost(40)
            ->setType(ExpenseType::ACCOMODATION)
            ->setPicture('imagecool');

         $manager->persist($expenseActivity, $expenseAccomodation);


        $activity = new Activity();
        $activity->setExpenseId($expenseActivity)
            ->setDescription('Activité cool')
            ->setStartAt(new \DateTimeImmutable('now'))
            ->setEndAt((new \DateTimeImmutable('now'))->add(new \DateInterval('P1D')));
        $manager->persist($activity);


        $accomodation = new Accomodation();
        $accomodation->setExpenseId($expenseAccomodation)
            ->setType(AccomodationType::CAMPING)
            ->setName('Camping')
            ->setCheckIn(new \DateTimeImmutable('now'))
            ->setCheckOut((new \DateTimeImmutable('now'))->add(new \DateInterval('P1D')))
            ->setBreakfast(true);
        $manager->persist($accomodation);

        $manager->flush();
    }

}
