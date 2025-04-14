<?php

namespace App\Factory;

use App\Entity\Accomodation;
use App\Entity\Expense;
use App\Entity\Activity;
use App\Enum\ExpenseType;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\Mapping\Entity;
use Doctrine\ORM\Mapping\EntityManager;

class ExpenseFactory
{

    public static function create(ExpenseType $type, array $data, EntityManagerInterface $entityManager): Expense
    {
        $expense= new Expense();
        $expense->setTitle($data['title']);
        $expense->setCost($data['cost']);
        $expense->isPayed($data['is_payed']);
        $expense->setPicture($data['picture']);
        $expense->setType($type);
            // $expense->setAdressId();
            // $expense->setVoyageId();

         switch ($type) {
            case ExpenseType::ACCOMODATION:
                $accomodation = new Accomodation();
                $accomodation->setName($data['name']);
                $accomodation->setType($data['accomodation_type']);
                $accomodation->setCheckIn($data['check_in']);
                $accomodation->setCheckOut($data['check_out']);
                $accomodation->setBreakfast($data['breakfast']);
                $accomodation->setSchedule($data['schedule']);
                $accomodation->setExpenseId($expense);
                
                $entityManager->persist($accomodation);
                $entityManager->flush();
                break;

            case ExpenseType::ACTIVITY:
                $activity = new Activity();
                $activity->setStartAt($data['start_at']);
                $activity->setEndAt($data['end_at']);
                $activity->setDescription($data['description']);
                $activity->setLink($data['link'] ?? null);
                $activity->setExpenseId($expense);

                $entityManager->persist($activity);
                $entityManager->flush();

                break;
        }
        return $expense;
    }
}
