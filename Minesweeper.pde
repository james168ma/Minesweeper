

import de.bezier.guido.*;
int NUM_ROWS = 6;
int NUM_COLS = 6;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup () {

    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    buttons = new MSButton[20][20];
    
    for(int row = 0; row < buttons.length; row++)

        for(int col = 0; col < buttons[row].length; col++)

            buttons[row][col] = new MSButton(row, col);
    
    setBombs();
}

public void setBombs() {

    int ranRow = (int)(((double)NUM_ROWS)*Math.random());
    int ranCol = (int)(((double)NUM_COLS)*Math.random());

    if(!bombs.contains(buttons[ranRow][ranCol])) {
        bombs.add(buttons[ranRow][ranCol]);
    }
}

public void draw () {

    background( 0 );
    if(isWon())
        displayWinningMessage();

}

public boolean isWon() {

    //your code here
    return false;

}

public void displayLosingMessage() {

    //your code here

}

public void displayWinningMessage() {

    //your code here

}

public class MSButton {

    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc ) {

        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager

    }

    public boolean isMarked() {

        return marked;

    }

    public boolean isClicked() {

        return clicked;
    
    }
    // called by manager
    
    public void mousePressed () {

        clicked = true;

        if(keyPressed) {

            marked = !marked;

            if(marked == false)

                clicked = false;

            else if(bombs.contains(buttons[r][c]))

                text("you lose",200, 200);

            else if(countBombs(r, c) > 0)

                label = label + countBombs(r, c);
            
            else {

                for(int i = r - 1; i < r + 1; i++)

                    for(int j = c - 1; j < c + 1; j++)

                        if(isValid(i, j) && !bombs.contains(buttons[i][j]))

                            buttons[i][j].mousePressed();
            }
        }        

    }

    public void draw () {

        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);

    }

    public void setLabel(String newLabel) {

        label = newLabel;

    }

    public boolean isValid(int r, int c) {

        if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
            return true;

        return false;

    }

    public int countBombs(int row, int col) {

        int numBombs = 0;

        for(int i = row - 1; i < row + 1; i++)

            for(int j = col - 1; j < col + 1; j++)

                if(isValid(i, j) && bombs.contains(buttons[i][j]))

                    numBombs++;

        return numBombs;

    }
    
}



