from pygame import *
init()

width = 800
height = 600

screen = display.set_mode((width, height))

class Invader:
	def __init__(self,x,y):
		size = 40
		self.img = image.load("Invader.png")
		self.img = transform.scale(self.img, (size, size))
		self.rect = Rect(x,y,self.img.get_width(), self.img.get_height())
		self.dx =2  # Direction

	def draw(self, screen):
		screen.blit(self.img, self.rect)
	def update(self):
		global width, height
		self.rect.x+=self.dx
		if self.Checkforcollision():
			self.changedirection()
        #checks the boundaries
	def Checkforcollision(self):
		return self.rect.right + self.dx >= width or self.rect.left + self.dx <= 0
           
	def changedirection(self):
		self.dx*=-1
		self.rect.y+=40

class Shooter:
	def __init__(self,x,y):
		size = 60
		self.img = image.load("Shooter.png")
		self.img = transform.scale(self.img, (size, size))
		self.rect = Rect(x,y,self.img.get_width(), self.img.get_height())
		self.dx=0
	def update(self):
		global width
		if self.rect.left+self.dx<0 or self.rect.right+self.dx>width:
			self.stop()
        
	def draw(self, screen):
		screen.blit(self.img, self.rect)




endgame = False


s = Shooter(370,500)

invader_list = []
y = 50
while y <= 150:
    x = 160
    while x <= 600:
        p = Invader(x,y)   #creates the object
        invader_list.append(p) # adds the object to the list
        x = x + 60
    y = y + 50

screen = display.set_mode((width, height))
c = time.Clock()
FPS = 120
while not endgame:
    for e in event.get():
        if e.type == QUIT:
            endgame = True
    screen.fill((0,0,0))
    for i in invader_list: # Loops through the list and draws each one of the objects
        i.update()
        i.draw(screen)
       
        
    s.draw(screen)
    c.tick(FPS)
    display.flip()
