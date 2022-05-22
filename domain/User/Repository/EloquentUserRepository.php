<?php

namespace Domain\User\Repository;

use App\Models\User;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Builder;

/**
 * EloquentUserRepository
 */
class EloquentUserRepository implements UserRepository
{
    private function getQuery(): Builder
    {
        return User::query();
    }

    public function findAll(): Collection|array
    {
        return $this->getQuery()->get();
    }

    public function paginate(): LengthAwarePaginator
    {
        return $this->getQuery()->paginate();
    }

    public function findOne(int $id): object|null
    {
        return $this->getQuery()->where('id', $id)->first();
    }

    public function create(array $data): User
    {
        return new User($data);
    }

    public function fill(User $user, array $data): User
    {
        return $user->fill($data);
    }

    public function save(User $user)
    {
        $user->save();
    }

    public function delete(User $user)
    {
        $user->delete();
    }

}
