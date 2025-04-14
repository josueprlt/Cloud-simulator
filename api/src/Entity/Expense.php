<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use App\Enum\ExpenseType;
use App\Repository\ExpenseRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ExpenseRepository::class)]
#[ApiResource]
class Expense
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $title = null;

    #[ORM\Column]
    private ?int $cost = null;

    #[ORM\Column(options: ['default' => false])]
    private bool $isPayed = false;

    #[ORM\Column(enumType: ExpenseType::class)]
    private ?ExpenseType $type = null;

    #[ORM\Column(length: 255)]
    private ?string $picture = null;

    #[ORM\OneToOne(mappedBy: 'expenseId', cascade: ['persist', 'remove'])]
    private ?Activity $activity = null;

    #[ORM\OneToOne(mappedBy: 'expenseId', cascade: ['persist', 'remove'])]
    private ?Accomodation $accomodation = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitle(): ?string
    {
        return $this->title;
    }

    public function setTitle(string $title): static
    {
        $this->title = $title;

        return $this;
    }

    public function getCost(): ?int
    {
        return $this->cost;
    }

    public function setCost(int $cost): static
    {
        $this->cost = $cost;

        return $this;
    }

    public function isPayed(): bool
    {
        return $this->isPayed;
    }

    public function setPayed(bool $isPayed): static
    {
        $this->isPayed = $isPayed;

        return $this;
    }

    public function getType(): ?ExpenseType
    {
        return $this->type;
    }

    public function setType(ExpenseType $type): static
    {
        $this->type = $type;

        return $this;
    }

    public function getPicture(): ?string
    {
        return $this->picture;
    }

    public function setPicture(string $picture): static
    {
        $this->picture = $picture;

        return $this;
    }

    public function getActivity(): ?Activity
    {
        return $this->activity;
    }

    public function setActivity(Activity $activity): static
    {
        // set the owning side of the relation if necessary
        if ($activity->getExpenseId() !== $this) {
            $activity->setExpenseId($this);
        }

        $this->activity = $activity;

        return $this;
    }

    public function getAccomodation(): ?Accomodation
    {
        return $this->accomodation;
    }

    public function setAccomodation(Accomodation $accomodation): static
    {
        // set the owning side of the relation if necessary
        if ($accomodation->getExpenseId() !== $this) {
            $accomodation->setExpenseId($this);
        }

        $this->accomodation = $accomodation;

        return $this;
    }
}
