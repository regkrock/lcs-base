Class {
	#name : 'LxxSkillsLoader',
	#superclass : 'LcsObjectsLoader',
	#category : 'Lcs-PrototypeSystem-Core',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Core'
}

{ #category : 'data' }
LxxSkillsLoader >> data [
	^ '1,Skill 1
2,Skill 2
3,Skill 3'
]

{ #category : 'data' }
LxxSkillsLoader >> fieldSeparators [
	^ {$,}
]

{ #category : 'data' }
LxxSkillsLoader >> loadFrom: aDataStream class: aTargetClass into: aTargetCollection [
	| newDomainObject | 
	[ aDataStream atEnd ] whileFalse: [
		newDomainObject := aTargetClass new.
		self populate: newDomainObject with: aDataStream nextLine.
		aTargetCollection add: newDomainObject]
]

{ #category : 'loading' }
LxxSkillsLoader >> loadInto: aTargetCollection [
	self
		loadFrom: self data readStream
		class: self targetClass
		into: aTargetCollection
]

{ #category : 'data' }
LxxSkillsLoader >> schema [
	^#( 'skillCode' 'skillName')
]

{ #category : 'configuration' }
LxxSkillsLoader >> targetClass [
	^ LxxSkill
]
