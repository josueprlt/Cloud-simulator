<?php

namespace App\DataFixtures;

use App\Entity\Expense;
use App\Enum\ExpenseType;
use App\Factory\ExpenseFactory;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class ExpenseFixtures extends Fixture
{

    /**
     * @throws \DateMalformedStringException
     */
    public function load(ObjectManager $manager): void
    {
        $factory = new ExpenseFactory();
        $expenseOther = new Expense();
        $expenseAccomodation = new Expense();
        $expenseActivity = new Expense();

        $activityData = [
            'title' => 'Activite', 
            'cost' => 4,
            'is_payed' => true,
            'picture' => 'coolpicture2.jpg',
            'start_at' => '2025-04-15',
            'end_at'=> '2025-04-20',
            'description'=> 'Une activité géniale',
            'link' => 'http://lien.com'
        ];

        $accomodationData = [
            'title' => 'Accomodation',
            'cost' => 4,
            'is_payed' => true,
            'picture' => 'coolpicture2.jpg',
            'name' => 'B&B', 
            'accomodation_type' => 'hotel',
            'check_in' => '2025-04-15',
            'check_out'=> '2025-04-20',
            'breakfast'=> true,
            'schedule' => 'Ouvert le lundi'
        ];

        $otherExpenseData = [
            'title' => 'Gauffre de liège banane nutella', 
            'cost' => 8,
            'is_payed' => true,
            'picture' => 'coolpicture25.jpg'
        ];

        $manager->persist($factory->create($expenseAccomodation, ExpenseType::ACCOMODATION, $accomodationData,$manager));
        $manager->persist($factory->create($expenseActivity, ExpenseType::ACTIVITY, $activityData, $manager));
        $manager->persist($factory->create($expenseOther, ExpenseType::OTHER, $otherExpenseData,$manager));

        $manager->flush();
    }
}
