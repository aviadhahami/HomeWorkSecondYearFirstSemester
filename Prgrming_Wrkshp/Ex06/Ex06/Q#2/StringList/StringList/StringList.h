#define LIST_SIZE 10

#ifdef STRINGLIST1
typedef char** StringList;
#endif

//#define STRINGLIST1
//#define STRINGLIST2

#ifdef STRINGLIST2
struct Node{
	char* data;
	struct Node* next;
};
typedef struct Node Node;
typedef struct Node* StringList;
#endif

//Inits a StringList type of variable
StringList initStringList();

//Input: a StringList and a string
//Logic: The function inserts the new string after the first string with same length.
//		 If non exit -> will inject it @ top of StringList.
//Output : StringList post insertion, all strings are sorted by length.
//Expections: Will throw back NULL if couldn't allocate memo
StringList insertStringByLength(char* string, StringList list);

//Input: StringList
//Output: Prints all the strings by their length (long to short),
//		  prefixed by their index number
void printStringList(StringList list);

//Free's the allocated memory !IMPORTANT
void freeStringList(StringList list);

//Get's a list and propagates the elements to the RHS by 1
void propagateRight(StringList, int);

//Will return 1 if the last element in the array is 1
int gotRoom(StringList);