@section('navbar')
    @parent
    <div class="navbar bg-base-100 border-b-[3px] border-dashed z-50 fixed h-[60px]">
        <div class="flex-1">
            <a href="/" class="btn btn-ghost normal-case text-xl">Travelliu</a>
        </div>
        <div class="flex-none">
            <ul class="menu menu-horizontal p-0 gap-2">
                @auth
                    <li class="bg-black rounded-md text-white"><a href="/logout">Logout</a></li>
                @endauth
                @guest
                    <li><a href="/register">Register</a></li>
                    <li class="bg-black rounded-md text-white"><a href="/login">Login</a></li>
                @endguest
            </ul>
        </div>
    </div>
    <div class="h-[60px]">

    </div>
@endsection
