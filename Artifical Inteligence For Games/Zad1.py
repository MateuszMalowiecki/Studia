from io import BufferedIOBase
from random import *
import sys
import time
class TicTacToe:
    board= [([0] * 9) for i in range(9)]
    meta_board= [([0] * 3) for i in range(3)]
    def __init__(self):
        self.play()
    def print_board(self, board):
        for i in range(9):
            for j in range(9):
                field=board[i][j]
                if field == 0:
                    print(" . ", file=sys.stderr)
                elif field == 1:
                    print(" O ", file=sys.stderr)
                else:
                    print(" X ", file=sys.stderr)
            print("\n", file=sys.stderr)
    def check_end_condition(self, upper_row, left_col, board):
        if board[upper_row][left_col] != 0 and board[upper_row][left_col] == board[upper_row][left_col + 1] and board[upper_row][left_col]==board[upper_row][left_col+2]:
            return board[upper_row][left_col]
        if board[upper_row+1][left_col] != 0 and board[upper_row+1][left_col] == board[upper_row+1][left_col + 1] and board[upper_row+1][left_col]==board[upper_row+1][left_col+2]:
            return board[upper_row+1][left_col]
        if board[upper_row+2][left_col] != 0 and board[upper_row+2][left_col] == board[upper_row+2][left_col + 1] and board[upper_row+2][left_col]==board[upper_row+2][left_col+2]:
            return board[upper_row+2][left_col]
        if board[upper_row][left_col] != 0 and board[upper_row][left_col] == board[upper_row+1][left_col] and board[upper_row][left_col]==board[upper_row+2][left_col]:
            return board[upper_row][left_col]
        if board[upper_row][left_col+1] != 0 and board[upper_row][left_col+1] == board[upper_row+1][left_col+1] and board[upper_row][left_col+1]==board[upper_row+2][left_col+1]:
            return board[upper_row][left_col+1]
        if board[upper_row][left_col+2] != 0 and board[upper_row][left_col+2] == board[upper_row+1][left_col+2] and board[upper_row][left_col+2]==board[upper_row+2][left_col+2]:
            return board[upper_row][left_col+2]
        if board[upper_row][left_col] != 0 and board[upper_row][left_col] == board[upper_row+1][left_col + 1] and board[upper_row][left_col]==board[upper_row+2][left_col+2]:
            return board[upper_row][left_col]
        if board[upper_row+2][left_col] != 0 and board[upper_row+2][left_col] == board[upper_row+1][left_col + 1]  and board[upper_row+2][left_col]==board[upper_row][left_col+2]:
            return board[upper_row+2][left_col]
        if 0 in board[upper_row:upper_row+3][left_col:left_col+3]:
            return 0
        return 2
    def get_available_actions_on_board(self, upper_row, left_col, board):
        print("Entered get_available_actions_on_board",file=sys.stderr)
        for i in range(upper_row, upper_row+3):
            for j in range(left_col, left_col+3):
                print(board[i][j],file=sys.stderr)
                if board[i][j]==0:
                    yield (i, j)
    
    def possible_meta_boards(self, meta_board):
        for i in range(2):
            for j in range(2):
                if meta_board[i][j] == 0:
                    yield(i, j)
    def simulate_game(self, first_move):
        agent_turn=True
        move=first_move
        simulation_board=self.board
        simulation_meta_board=self.meta_board
        meta_board_position=(move[0] // 3, move[1] // 3,)
        res=self.check_end_condition(0, 0, simulation_meta_board)
        while res == 0:
            #self.print_board(simulation_board)
            if agent_turn:
                simulation_board[move[0]][move[1]] = 1
            else:
                simulation_board[move[0]][move[1]] = -1
            meta_board_position=(move[0] // 3, move[1] // 3)
            simulation_meta_board[meta_board_position[0]][meta_board_position[1]] = self.check_end_condition(meta_board_position[0], meta_board_position[1], simulation_board)
            res=self.check_end_condition(0, 0, simulation_meta_board)
            if res != 0:
                return res
            next_move_meta_boards=list(self.possible_meta_boards(simulation_meta_board))
            print(f"next move meta boards number: {len(next_move_meta_boards)}", file=sys.stderr)
            available_positions=[]
            if meta_board_position in next_move_meta_boards:
                available_positions=list(self.get_available_actions_on_board(3 * meta_board_position[0], 3 * meta_board_position[1], simulation_board))
            else:
                for i, j in next_move_meta_boards:
                    available_positions = available_positions + list(self.get_available_actions_on_board(3 * i, 3 * j, simulation_board))
            print(f"number of positions: {len(available_positions)}", file=sys.stderr)
            move=available_positions[randint(0, len(available_positions)-1)]
            agent_turn = not agent_turn
        return res

    def make_best_move(self, agent_start):
        n = len(self.available)
        num_of_times=[0 for i in range(n)]
        rewards=[0 for i in range(n)]
        potential_end=time.time()
        while potential_end - agent_start < 0.001:
            #print(potential_end - agent_start, file=sys.stderr)
            selected_action=randint(0, n-1)
            reward=self.simulate_game(self.available[selected_action])
            num_of_times[selected_action] += 1
            rewards[selected_action] += reward
            potential_end=time.time()
        best_action_index=0
        max_reward=rewards[best_action_index]/num_of_times[best_action_index]
        for i in range(1, n-1):
            potential_max_reward=rewards[i]/num_of_times[i]
            if potential_max_reward > max_reward:
                max_reward=potential_max_reward
                best_action_index=i
        return self.available[best_action_index]
        #Here will be implemenation of MCTS.
    def play(self):
        #last_move=(-1, -1)
        opponent_move=True
        while True:
            self.available=[]
            opponent_row, opponent_col = [int(i) for i in input().split()]
            self.board[opponent_row][opponent_col]=-1
            meta_board_state=self.check_end_condition(opponent_row // 3, opponent_col // 3, self.board)
            self.meta_board[opponent_row // 3][opponent_col // 3] = meta_board_state
            valid_action_count = int(input())
            for i in range(valid_action_count):
                row, col = [int(j) for j in input().split()]
                self.available.append((row, col))
            agent_start=time.time()
            (row, col) = self.make_best_move(agent_start)
            self.board[row][col]=1
            meta_board_state=self.check_end_condition(row // 3, col // 3, self.board)
            self.meta_board[row // 3][col // 3] = meta_board_state
            print(f"{row} {col}")
TicTacToe()