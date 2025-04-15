<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use ApiPlatform\Metadata\Delete;
use ApiPlatform\Metadata\Get;
use ApiPlatform\Metadata\GetCollection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

#[ORM\Entity]
#[ApiResource(
    operations: [
        new Get(),
        new GetCollection(),
        new Delete()
    ]
)]
class Activity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private int $id;

    #[ORM\Column]
    #[Assert\NotBlank(message: "La date de début ne peut pas être vide.")]
    private \DateTimeImmutable $startAt;

    #[ORM\Column]
    #[Assert\NotBlank(message: "La date de fin ne peut pas être vide.")]
    private \DateTimeImmutable $endAt;

    #[ORM\Column(type: 'text')]
    #[Assert\NotBlank(message: "La description ne peut pas être vide.")]
    private string $description;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $link = null;

    #[ORM\OneToOne(inversedBy: 'activity', cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    private Expense $expenseId;

    public function getId(): int
    {
        return $this->id;
    }

    public function getStartAt(): \DateTimeImmutable
    {
        return $this->startAt;
    }

    public function setStartAt(\DateTimeImmutable $startAt): static
    {
        $this->startAt = $startAt;

        return $this;
    }

    public function getEndAt(): \DateTimeImmutable
    {
        return $this->endAt;
    }

    public function setEndAt(\DateTimeImmutable $endAt): static
    {
        $this->endAt = $endAt;

        return $this;
    }

    public function getDescription(): string
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
