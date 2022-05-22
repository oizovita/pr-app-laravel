<?php

namespace Domain\User\Repository;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use App\Models\User;

interface UserRepository
{
    public function findAll();

    public function paginate();

    public function findOne(int $id);

    public function create(array $data);

    public function fill(User $user, array $data);
}
