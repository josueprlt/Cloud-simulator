<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use App\Repository\ActivityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ActivityRepository::class)]
#[ApiResource]
class Activity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $startAt = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $endAt = null;

    #[ORM\Column(type: 'text')]
    private ?string $description = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $link = null;

    #[ORM\OneToOne(inversedBy: 'activity', cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    private ?Expense $expenseId = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getStartAt(): ?\DateTimeImmutable
    {
        return $this->startAt;
    }

    public function setStartAt(\DateTimeImmutable $startAt): static
    {
        $this->startAt = $startAt;

        return $this;
    }

    public function getEndAt(): ?\DateTimeImmutable
    {
        return $this->endAt;
    }

    public function setEndAt(\DateTimeImmutable $endAt): static
    {
        $this->endAt = $endAt;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(string $description): static
    {
        $this->description = $description;

        return $this;
    }

    public function getLink(): ?string
    {
        return $this->link;
    }

    public function setLink(?string $link): static
    {
        $this->link = $link;

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
