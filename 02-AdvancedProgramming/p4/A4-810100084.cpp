#include <iostream>
#include <cstdlib>
#include <string>
#include <vector>
#include <algorithm>
#include <cstring>

using namespace std;

#define INITIAL_HEALTH 100
#define WINNER_PRIZE 2700
#define LOOSER_PRIZE 2400
#define MAX_MONEY 10000
#define STARTED 1
#define NOT_STARTED 0
#define FIGHT_START "fight!\n"
#define START_COMMAND "start"
#define ADD_USER_COMMAND "add-user"
#define TERRORIST_TEAM_NAME "terrorist"
#define COUNTER_TERRORIST_TEAM_NAME "counter-terrorist"
#define TERRORIST_TYPE 0
#define COUNTER_TERRORIST_TYPE 1
#define PLAYER_DOESNT_EXIST_MESSAGE "player doesnt exist\n"
#define CANT_PLAY 0
#define CAN_PLAY 1
#define ATK_AFK_RESPONSE "ok\n"
#define ADD_USER_RESPONSE "ok\n"
#define START_COMMAND "start"
#define GET_MONEY_COMMAND "get-money"
#define GET_HEALTH_COMMAND "get-health"
#define GO_AFK_COMMAND "go-afk"
#define GO_ATK_COMMAND "go-atk"
#define USER_CANT_PLAY "user not available"
#define ATTACKER_DEAD_MESSAGE "attacker is dead"
#define ATTACKED_DEAD_MESSAGE "attacked is dead"
#define DOESNT_HAVE_GUN_MASSAGE "attacker doesn't have this gun"
#define TEAMMATE_ATTACK_MESSAGE "you can't shoot this player"
#define COLLISION_MESSAGE "nice shot"
#define NOT_STARTED_GAME_MESSAGE "The game hasn't started yet"
#define LESS_MONEY_MESSAGE "insufficient money"
#define BUY_WEAPON_AFTER_START "you can't buy weapons anymore"
#define ALREADY_HAVE_WEAPON_MESSAGE "you already have this weapon"
#define GUN_BOUGHT_SUCCESSFULLY "weapon bought successfully"
#define NOT_DEFINED_WEAPON_MESSAGE "weapon not available"
#define SHOOT_COMMAND "shoot"
#define BUY_COMMAND "buy"
#define TITLE_OF_COUNTER_TERRORISTS_SCORE_BOARD "counter-terrorist players:"
#define TITLE_OF_TERRORISTS_SCORE_BOARD "terrorist players:"
#define SCORE_BOARD "score-board"
#define TERRORISTS_WIN "terrorist won"
#define COUNTER_TERRORIST_WIN "counter-terrorist won"
#define PISTOL_PRICE 400
#define HEAVY_PRICE 3000
#define PISTOL_DAMAGE 20
#define HEAVY_DAMAGE 45
#define PISTOL_BONUS  200
#define HEAVY_bonus 100
#define KNIFE_PRICE 0
#define KNIFE_DAMAGE 35
#define KNIFE_BONUS 500
#define INITIAL_MONEY 1000
#define HAVE 1
#define DONT_HAVE 0

class gun
{
public:
    gun(string Tname, int Tprice, int Tdamage, int Tbonus)
    {
        price = Tprice;
        damage = Tdamage;
        bonus = Tbonus;
        name = Tname;
    };
    int get_damage() { return damage; };
    int get_bonus() { return bonus; };
    int get_price() { return price; };
    string get_name() { return name; };

private:
    string name;
    int price;
    int damage;
    int bonus;
};
const gun pistol("pistol", PISTOL_PRICE, PISTOL_DAMAGE, PISTOL_BONUS);
const gun heavy("heavy", HEAVY_PRICE, HEAVY_DAMAGE, HEAVY_bonus);
const gun knife("knife", KNIFE_PRICE, KNIFE_DAMAGE, KNIFE_BONUS);

class player
{
public:
    player(int temp_health = INITIAL_HEALTH, int temp_money = INITIAL_MONEY, bool temp_have_pistol = DONT_HAVE, bool temp_have_heavy = DONT_HAVE);
    void set_initial_data(int temp_health, int temp_money, bool temp_have_pistol, bool temp_have_heavy);
    int get_money() { return money; };
    int get_health() { return health; };
    string get_name() { return username; }
    bool get_team() { return team; };
    void set_team(string team_name);
    void update_round();
    void add_winner_money();
    void add_looser_money();
    void set_username(string username);
    bool get_can_play() { return can_play; };
    bool get_have_pistol() { return have_pistol; };
    bool get_have_heavy() { return have_heavy; };
    void check_money();
    void collision(gun weapon);
    void kill(gun killer_gun);
    void buy(gun weapon);
    int get_deaths() { return deaths; };
    int get_kills() { return kills; };
    void go_afk();
    void go_atk();

private:
    string username;
    int health;
    int money;
    bool have_pistol;
    bool have_heavy;
    bool can_play;
    bool team;
    int kills;
    int deaths;
};

class game
{
private:
    bool game_status;
    vector<player> terrorists;
    vector<player> counter_terrorists;

public:
    game()
    {
        game_status = NOT_STARTED;
        terrorists = vector<player>();
        counter_terrorists = vector<player>();
    }
    void update_players(player to_be_update);
    player change_name_to_player(string name);
    bool check_existed(string uname);
    player find_player(string player_name);
    void get_money(string uname);
    void get_health(string uname);
    void start();
    void winner_announced();
    void score_board();
    void add_user(string uname, string team);
    void set_team();
    void go_afk(string uname);
    void go_atk(string uname);
    void shoot(string attacker_name, string attacked_name, string weapon_name);
    void buy(string buyer_name, string weapon_name);
};

void player ::add_winner_money()
{
    money += WINNER_PRIZE;
    check_money();
}

void player ::add_looser_money()
{
    money += LOOSER_PRIZE;
    check_money();
}

void player::check_money()
{
    if (money > MAX_MONEY)
    {
        money = MAX_MONEY;
    }
}

bool order_func(player player1, player player2)
{
    return (player1.get_kills() > player2.get_kills());
}

vector<player> prioritize(vector<player> &players)
{
    sort(players.begin(), players.end(), order_func);
    for (int i = 0; i < players.size() - 1; i++)
    {
        if (players[i].get_kills() == players[i + 1].get_kills())
        {
            if (players[i].get_deaths() > players[i + 1].get_deaths())
            {
                player temp_player;
                temp_player = players[i];
                players[i] = players[i + 1];
                players[i + 1] = temp_player;
            }
            else if (players[i].get_deaths() == players[i + 1].get_deaths())
            {
                int compare = strcmp(players[i].get_name().c_str(), players[i+1].get_name().c_str());
                if (compare > 0)
                {
                    player tem_player;
                    tem_player = players[i];
                    players[i] = players[i + 1];
                    players[i + 1] = tem_player;
                }
            }
            else
            {
                continue;
            }
        }
    }
    return players;
}

void game ::score_board()
{
    cout << TITLE_OF_COUNTER_TERRORISTS_SCORE_BOARD << endl;
    terrorists = prioritize(terrorists);
    counter_terrorists = prioritize(counter_terrorists);
    for (int i = 0; i < counter_terrorists.size(); i++)
    {
        cout << counter_terrorists[i].get_name() << " " << counter_terrorists[i].get_kills()
             << " " << counter_terrorists[i].get_deaths() <<endl;
    }
    cout << TITLE_OF_TERRORISTS_SCORE_BOARD << endl;
    for (int i = 0; i < terrorists.size(); i++)
    {
        cout << terrorists[i].get_name() << " " << terrorists[i].get_kills()
             << " " << terrorists[i].get_deaths() << endl;
    }
}

gun change_weapon_name_to_weapon(string weapon_name)
{
    gun undefined_gun("undefined", 0, 0, 0);
    if (weapon_name == "heavy")
    {
        return heavy;
    }
    else if (weapon_name == "knife")
    {
        return knife;
    }
    else if (weapon_name == "pistol")
    {
        return pistol;
    }
    else
    {
        return undefined_gun;
    }
}

void player::buy(gun weapon)
{
    money -= weapon.get_price();
    if (money < 0)
    {
        money += weapon.get_price();
    }
    else if (weapon.get_name() == "pistol")
    {
        have_pistol = 1;
    }
    else if (weapon.get_name() == "heavy")
    {
        have_heavy = 1;
    }
}

void player::collision(gun weapon)
{
    health -= weapon.get_damage();
    if (health <= 0)
    {
        health = 0;
        have_heavy = 0;
        have_pistol = 0;
        deaths++;
    }
}

void player ::kill(gun killer_gun)
{
    money += killer_gun.get_bonus();
    check_money();
    kills++;
}

int check_buy_condition(player &buyer, gun weapon)
{
    if ((buyer.get_money() <= weapon.get_price()))
    {
        cout << LESS_MONEY_MESSAGE << endl;
        return 0;
    }
    else if (buyer.get_can_play() == CANT_PLAY)
    {
        cout << USER_CANT_PLAY << endl;
        return 0;
    }
    else if (weapon.get_name() != "heavy" && weapon.get_name() != "pistol" && weapon.get_name() != "knife")
    {
        cout << NOT_DEFINED_WEAPON_MESSAGE << endl;
        return 0;
    }
    else if (((weapon.get_name() == "heavy") && (buyer.get_have_heavy())) ||
             ((weapon.get_name() == "pistol") && (buyer.get_have_pistol())) ||
             (weapon.get_name() == "knife"))
    {
        cout << ALREADY_HAVE_WEAPON_MESSAGE << endl;
        return 0;
    }
    else
    {
        return 1;
    }
}

player game ::change_name_to_player(string name)
{
    player undefined_player;
    for (int i = 0; i < terrorists.size(); i++)
    {
        if (terrorists[i].get_name() == name)
        {
            return terrorists[i];
        }
    }
    for (int i = 0; i < counter_terrorists.size(); i++)
    {
        if (counter_terrorists[i].get_name() == name)
        {
            return counter_terrorists[i];
        }
    }
    undefined_player.set_username("undefined");
    return undefined_player;
}

void game ::buy(string buyer_name, string weapon_name)
{
    gun weapon(weapon_name, 0, 0, 0);
    player buyer;
    int check_exist = 0;
    buyer = change_name_to_player(buyer_name);
    if ((buyer.get_name() == "undefined"))
    {
        cout << USER_CANT_PLAY << endl;
        return;
    }
    weapon = change_weapon_name_to_weapon(weapon_name);
    if (game_status == STARTED)
    {
        cout << BUY_WEAPON_AFTER_START << endl;
    }
    else if (check_buy_condition(buyer, weapon))
    {
        buyer.buy(weapon);
        cout << GUN_BOUGHT_SUCCESSFULLY << endl;
    }
    update_players(buyer);
}

player::player(int temp_health, int temp_money, bool temp_have_pistol, bool temp_have_heavy)
{
    set_initial_data(temp_health, temp_money, temp_have_pistol, temp_have_heavy);
}

void player ::set_initial_data(int temp_health, int temp_money, bool temp_have_pistol, bool temp_have_heavy)
{
    health = temp_health;
    money = temp_money;
    have_pistol = temp_have_pistol;
    have_heavy = temp_have_heavy;
    deaths = 0;
    kills = 0;
    can_play = CAN_PLAY ;
}

void player ::set_team(string team_name)
{
    if (team_name == "terrorist")
    {
        team = TERRORIST_TYPE;
    }
    else
    {
        team = COUNTER_TERRORIST_TYPE;
    }
}

void player ::set_username(string name)
{
    username = name;
}

void game ::start()
{
    if (!game_status)
    {
        game_status = STARTED;
        cout << FIGHT_START;
    }
    else
    {
        cout << "The game has already been started" << endl;
    }
}

vector<string> mystrtok(string str, char delim)
{
    vector<string> tokens;
    string temp = "";
    for (int i = 0; i < str.length(); i++)
    {
        if (str[i] == delim)
        {
            tokens.push_back(temp);
            temp = "";
        }
        else
            temp += str[i];
    }
    tokens.push_back(temp);
    return tokens;
}

void game ::add_user(string uname, string team)
{
    player my_player;
    if (!game_status)
    {
        my_player.set_username(uname);
        my_player.set_team(team);
        if (my_player.get_team() == TERRORIST_TYPE)
        {
            terrorists.push_back(my_player);
            cout << ADD_USER_RESPONSE;
        }
        else
        {
            counter_terrorists.push_back(my_player);
            cout << ADD_USER_RESPONSE;
        }
    }
}

bool game ::check_existed(string uname)
{
    for (int i = 0; i < terrorists.size(); i++)
    {
        if (uname.compare(terrorists[i].get_name()) == 0)
        {
            return 1;
        }
    }
    for (int i = 0; i < counter_terrorists.size(); i++)
    {
        if (uname.compare(counter_terrorists[i].get_name()) == 0)
        {
            return 1;
        }
    }
    return 0;
}

player game ::find_player(string uname)
{
    if (!check_existed(uname))
    {
        cout << PLAYER_DOESNT_EXIST_MESSAGE;
    }
    for (int i = 0; i < terrorists.size(); i++)
    {
        if (uname.compare(terrorists[i].get_name()) == 0)
        {
            return terrorists[i];
        }
    }
    for (int i = 0; i < counter_terrorists.size(); i++)
    {
        if (uname.compare(counter_terrorists[i].get_name()) == 0)
        {
            return counter_terrorists[i];
        }
    }
    player Null_player;
    cout << "returning Null player";
    return Null_player;
}

void game::get_money(string uname)
{
    player choosen_player;
    choosen_player = find_player(uname);
    cout << choosen_player.get_money() << endl;
}

void game::get_health(string uname)
{
    player choosen_player;
    choosen_player = find_player(uname);
    cout << choosen_player.get_health() << endl;
}

void game::go_afk(string uname)
{
    for (int i = 0; i < terrorists.size(); i++)
    {
        if (uname == terrorists[i].get_name())
        {
            terrorists[i].go_afk();
        }
    }
    for (int i = 0; i < counter_terrorists.size(); i++)
    {
        if (uname == counter_terrorists[i].get_name())
        {
            counter_terrorists[i].go_afk();
        }
    }
}

void player::go_afk()
{
    can_play = CANT_PLAY;
    cout << ATK_AFK_RESPONSE;
}

void game::go_atk(string uname)
{
    player choosen_player;
    choosen_player = find_player(uname);
    for (int i = 0; i < terrorists.size(); i++)
    {
        if (choosen_player.get_name() == terrorists[i].get_name())
        {
            terrorists[i].go_atk();
        }
    }
    for (int i = 0; i < counter_terrorists.size(); i++)
    {
        if (choosen_player.get_name() == counter_terrorists[i].get_name())
        {
            counter_terrorists[i].go_atk();
        }
    }
}

void player::go_atk()
{
    can_play = CAN_PLAY;
    cout << ATK_AFK_RESPONSE;
}

bool check_conditions(player attacker, player attacked, gun weapon)
{
    if ((attacker.get_can_play() == CANT_PLAY) || (attacked.get_can_play() == CANT_PLAY))
    {
        cout << USER_CANT_PLAY << endl;
        return 0;
    }
    else if ((attacker.get_health() <= 0))
    {
        cout << ATTACKER_DEAD_MESSAGE << endl;
        return 0;
    }
    else if (attacked.get_health() <= 0)
    {
        cout << ATTACKED_DEAD_MESSAGE << endl;
        return 0;
    }
    else if ((((weapon.get_name() == "heavy") && (attacker.get_have_heavy() == 0)) ||
              ((weapon.get_name() == "pistol") && (attacker.get_have_pistol() == 0))) &&
             (weapon.get_name() != "knife"))
    {
        cout << DOESNT_HAVE_GUN_MASSAGE << endl;
        return 0;
    }
    else if (attacked.get_team() == attacker.get_team())
    {
        cout << TEAMMATE_ATTACK_MESSAGE << endl;
        return 0;
    }
    else
    {
        return 1;
    }
}

void game ::update_players(player to_be_update)
{
    if (to_be_update.get_team() == TERRORIST_TYPE)
    {
        for (int i = 0; i < terrorists.size(); i++)
        {
            if (terrorists[i].get_name() == to_be_update.get_name())
            {
                terrorists[i] = to_be_update;
                break;
            }
        }
    }
    if (to_be_update.get_team() == COUNTER_TERRORIST_TYPE)
    {
        for (int i = 0; i < counter_terrorists.size(); i++)
        {
            if (counter_terrorists[i].get_name() == to_be_update.get_name())
            {
                counter_terrorists[i] = to_be_update;
                break;
            }
        }
    }
}

void game ::shoot(string attacker_name, string attacked_name, string weapon_name)
{
    gun weapon(weapon_name, 0, 0, 0);
    player attacker;
    player attacked;
    attacker = change_name_to_player(attacker_name);
    attacked = change_name_to_player(attacked_name);
    if ((attacked.get_name() == "undefined") || (attacker.get_name() == "undefined"))
    {
        cout << USER_CANT_PLAY << endl;
        return;
    }
    weapon = change_weapon_name_to_weapon(weapon_name);
    if (game_status != STARTED)
    {
        cout << NOT_STARTED_GAME_MESSAGE << endl;
    }
    else if (check_conditions(attacker, attacked, weapon))
    {
        attacked.collision(weapon);
        if (attacked.get_health() <= 0)
        {
            attacker.kill(weapon);
        }
        cout << COLLISION_MESSAGE << endl;
    }
    update_players(attacked);
    update_players(attacker);
}

void find_command(string command, game &my_game)
{
    vector<string> tokens;
    string behest;
    tokens = mystrtok(command, ' ');
    behest = tokens[0];
    if (behest == START_COMMAND)
    {
        my_game.start();
    }
    else if (behest == ADD_USER_COMMAND)
    {
        my_game.add_user(tokens[1], tokens[2]);
    }
    else if (behest == GET_MONEY_COMMAND)
    {
        my_game.get_money(tokens[1]);
    }
    else if (behest == GET_HEALTH_COMMAND)
    {
        my_game.get_health(tokens[1]);
    }
    else if (behest == GO_AFK_COMMAND)
    {
        my_game.go_afk(tokens[1]);
    }
    else if (behest == GO_ATK_COMMAND)
    {
        my_game.go_atk(tokens[1]);
    }
    else if (behest == SHOOT_COMMAND)
    {
        my_game.shoot(tokens[1], tokens[2], tokens[3]);
    }
    else if (behest == BUY_COMMAND)
    {
        my_game.buy(tokens[1], tokens[2]);
    }
    else if (behest == SCORE_BOARD)
    {
        my_game.score_board();
    }
    else
    {
        cout << "not true command\n";
    }
}

void game ::winner_announced()
{
    for (int i = 0; i < counter_terrorists.size(); i++)
    {
        if ((counter_terrorists[i].get_health() != 0) && (counter_terrorists[i].get_can_play() == CAN_PLAY))
        {
            for (int j =0 ; j < counter_terrorists.size() ; j++){
                counter_terrorists[j].update_round();
                counter_terrorists[j].add_winner_money();
            }
            cout << COUNTER_TERRORIST_WIN << endl;
            for (int i = 0; i < terrorists.size(); i++)
            {
                terrorists[i].add_looser_money();
                terrorists[i].update_round();
            }
            game_status = NOT_STARTED ;
            return;
        }
        counter_terrorists[i].update_round();
    }

    for (int i = 0; i < terrorists.size(); i++)
    {
        if ((terrorists[i].get_health() != 0) && (terrorists[i].get_can_play() == CAN_PLAY))
        {
            for (int j =0 ; j < terrorists.size() ; j++){
                terrorists[j].update_round();
                terrorists[j].add_winner_money();
            }
            cout << TERRORISTS_WIN << endl;
            for (int z =0 ; z < counter_terrorists.size() ; z++){
                counter_terrorists[z].add_looser_money();
                counter_terrorists[z].update_round();
            }
            game_status = NOT_STARTED ;
            return ;
        }
        terrorists[i].update_round();
    }  
}

void result(game &my_game)
{
    my_game.winner_announced();
}

void player ::update_round()
{
    health = INITIAL_HEALTH;
}

void input(string &command, game &my_game)
{
    int number_of_rounds;
    int number_of_commands;
    string is_round;
    vector<string> tokens;
    while (cin >> number_of_rounds)
    {
        for (int i = 0; i < number_of_rounds; i++)
        {
            while (cin >> is_round)
            {
                getline(cin, command);
                command = is_round + command;
                tokens = mystrtok(command, ' ');
                if (is_round == "round")
                {
                    number_of_commands = stoi(tokens[1]);
                    for (int j = 0; j < number_of_commands; j++)
                    {
                        getline(cin, command);
                        find_command(command, my_game);
                    }
                    result(my_game);
                }
                else
                {
                    find_command(command, my_game);
                }
            }
        }
    }
}

int main()
{
    string command;
    game my_game = game();
    input(command, my_game);
    return 0;
}