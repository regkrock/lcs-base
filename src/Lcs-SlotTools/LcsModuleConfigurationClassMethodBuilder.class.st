Class {
	#name : 'LcsModuleConfigurationClassMethodBuilder',
	#superclass : 'LcsMethodBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'properties - accessing' }
LcsModuleConfigurationClassMethodBuilder >> configurationClassName [
	^ self propertyAt: #'configurationClassName'
]

{ #category : 'properties - accessing' }
LcsModuleConfigurationClassMethodBuilder >> configurationClassName: aString [
	^ self propertyAt: #'configurationClassName' put: aString
]

{ #category : 'initialize' }
LcsModuleConfigurationClassMethodBuilder >> initialize [
	super initialize.
	self selector: #moduleConfigurationClass.
	self beClassMethod
]

{ #category : 'code generation templates' }
LcsModuleConfigurationClassMethodBuilder >> methodSource [
	^'<1s>
	^ <2s>' expandMacrosWith: self selector with: self configurationClassName
]
