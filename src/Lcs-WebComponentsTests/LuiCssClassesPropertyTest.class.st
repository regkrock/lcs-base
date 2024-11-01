Class {
	#name : #LuiCssClassesPropertyTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #tests }
LuiCssClassesPropertyTest >> testAddingCssClass [
	| cssClassesProperty |
	cssClassesProperty := LuiCssClassesProperty new.
	cssClassesProperty addCssClass: 'testClass'.
	self assert: cssClassesProperty cssClasses size = 1.
	self assert: cssClassesProperty cssClasses first equals: 'testClass'.
	self assert: cssClassesProperty cssClassesString = 'testClass'.
	cssClassesProperty addCssClass: 'testClass2'.
	self assert: cssClassesProperty cssClassesString = 'testClass testClass2'.
]

{ #category : #tests }
LuiCssClassesPropertyTest >> testAddingDuplicateCssClass [
	| cssClassesProperty |
	cssClassesProperty := LuiCssClassesProperty new.
	cssClassesProperty addCssClass: 'testClass'.
	self assert: cssClassesProperty cssClasses size = 1.
	cssClassesProperty addCssClass: 'testClass'.
	self assert: cssClassesProperty cssClasses size = 1.

]

{ #category : #tests }
LuiCssClassesPropertyTest >> testCreation [
	| cssClassesProperty |
	cssClassesProperty := LuiCssClassesProperty new.
	self assert: cssClassesProperty cssClasses isEmpty.
	self assert: cssClassesProperty cssClassesString isEmpty
]

{ #category : #tests }
LuiCssClassesPropertyTest >> testCssClassString [
	| cssClassesProperty |
	cssClassesProperty := LuiCssClassesProperty new.
	self assert: cssClassesProperty cachedValue isNil.
	self assert: cssClassesProperty cssClassesString isEmpty.
	self assert: cssClassesProperty propertyValue isEmpty.
	
	cssClassesProperty addCssClass: 'testClass'.
	self assert: cssClassesProperty cachedValue isNil.
	self assert: cssClassesProperty cssClassesString equals: 'testClass'.
	self assert: cssClassesProperty cachedValue isNil.
	self assert: cssClassesProperty propertyValue equals: 'testClass'.
	self assert: cssClassesProperty propertyValue equals: cssClassesProperty cachedValue.

	cssClassesProperty removeCssClass: 'testClass'.
	self assert: cssClassesProperty cachedValue isNil.
	self assert: cssClassesProperty cssClassesString isEmpty.
	self assert: cssClassesProperty propertyValue isEmpty.

]

{ #category : #tests }
LuiCssClassesPropertyTest >> testRemovingCssClass [
	| cssClassesProperty |
	cssClassesProperty := LuiCssClassesProperty new.
	cssClassesProperty addCssClass: 'testClass'.
	self assert: cssClassesProperty cssClasses size = 1.
	cssClassesProperty removeCssClass: 'testClass'.
	self assert: cssClassesProperty cssClasses isEmpty. 
]
