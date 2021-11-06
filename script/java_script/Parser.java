import java.io.*;
class Parser {
    static int lookahead;
    public Parser() throws IOException{
        lookahead = System.io.read();
    }
    void expr() throws IOException {
        term();
        while(true){
            if(lookahead == '+'){
                match('+');term;System.io.write('+')
            }
            else if(lookahead == '-'){
                match('-');term;System.io.write('-')
            }
            else return;
        }
    }
    void term() throws IOExcetion {
        if (Character.isDigit((char)lookahead)){
            System.out.write((char)lookahead)

        }else throw new Error ("syntax error");
    }
    void match(int t) throws IOException {
        if (lookahead == t) lookahead = System.io.read();
        else throw new Error ("syntax error");
    }
}


public class Postfix {
    public static void main(String[] args){
        Parser parser = new Parser();
        parser.expr();System.out.write('\n');
    }
}
