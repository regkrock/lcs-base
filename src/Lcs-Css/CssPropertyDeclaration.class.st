Class {
	#name : #CssPropertyDeclaration,
	#superclass : #CssObject,
	#instVars : [
		'propertyName',
		'propertyValue'
	],
	#category : #'Lcs-Css'
}

{ #category : #'instance creation' }
CssPropertyDeclaration class >> on: aRuleSet [
	^ self new
		initializeOn: aRuleSet;
		yourself
]

{ #category : #printing }
CssPropertyDeclaration >> compressedCssOn: aStream [
	aStream nextPutAll: self compressedDeclaration
]

{ #category : #printing }
CssPropertyDeclaration >> compressedDeclaration [
	^ self propertyName , ':' , self propertyValue , ';'
]

{ #category : #printing }
CssPropertyDeclaration >> declaration [
	^ self propertyName , ': ' , self propertyValue , ';'
]

{ #category : #example }
CssPropertyDeclaration >> declarationExample [
	<gtExample>
	| declaration |
	declaration := CssPropertyDeclaration new 
					propertyName: 'color';
					propertyValue: 'red';
					yourself.
	self assert: declaration propertyName = 'color'.
	self assert: declaration propertyValue = 'red'.
	self assert: declaration prettyCssString equals: 'color: red;'.
	self assert: declaration compressedCssString equals: 'color:red;'.
	^declaration
]

{ #category : #initialize }
CssPropertyDeclaration >> initializeOn: aRuleSet [ 
	self parent: aRuleSet
]

{ #category : #printing }
CssPropertyDeclaration >> prettyCssOn: aStream [
	aStream nextPutAll: self declaration
]

{ #category : #accessing }
CssPropertyDeclaration >> propertyName [
	^ propertyName
]

{ #category : #accessing }
CssPropertyDeclaration >> propertyName: aString [
	propertyName := aString
]

{ #category : #accessing }
CssPropertyDeclaration >> propertyValue [
	^ propertyValue
]

{ #category : #accessing }
CssPropertyDeclaration >> propertyValue: aString [
	propertyValue := aString
]
