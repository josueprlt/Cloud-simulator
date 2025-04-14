<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use App\Enum\AccomodationType;
use App\Repository\AccomodationRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: AccomodationRepository::class)]
#[ApiResource]
class Accomodation
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $name = null;

    #[ORM\Column(enumType: AccomodationType::class)]
    private ?AccomodationType $type = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $checkIn = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $checkOut = null;

    #[ORM\Column]
    private ?bool $breakfast = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $schedule = null;

    #[ORM\OneToOne(inversedBy: 'accomodation', cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    private ?Expense $expenseId = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): static
    {
        $this->name = $name;

        return $this;
    }

    public function getType(): ?AccomodationType
    {
        return $this->type;
    }

    public function setType(AccomodationType $type): static
    {
        $this->type = $type;

        return $this;
    }

    public function getCheckIn(): ?\DateTimeImmutable
    {
        return $this->checkIn;
    }

    public function setCheckIn(\DateTimeImmutable $checkIn): static
    {
        $this->checkIn = $checkIn;

        return $this;
    }

    public function getCheckOut(): ?\DateTimeImmutable
    {
        return $this->checkOut;
    }

    public function setCheckOut(\DateTimeImmutable $checkOut): static
    {
        $this->checkOut = $checkOut;

        return $this;
    }

    public function isBreakfast(): ?bool
    {
        return $this->breakfast;
    }

    public function setBreakfast(bool $breakfast): static
    {
        $this->breakfast = $breakfast;

        return $this;
    }

    public function getSchedule(): ?string
    {
        return $this->schedule;
    }

    public function setSchedule(?string $schedule): static
    {
        $this->schedule = $schedule;

        return $this;
    }

    public function getExpenseId(): ?Expense
    {
        return $this->expenseId;
    }

    public function setExpenseId(Expense $expenseId): static
    {
        $this->expenseId = $expenseId;

        return $this;
    }
}
