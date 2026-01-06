Class {
	#name : 'LcsBasicSystemTest',
	#superclass : 'LcsAbstractSystemTest',
	#category : 'Lcs-DemoSystemTests',
	#package : 'Lcs-DemoSystemTests'
}

{ #category : 'tests' }
LcsBasicSystemTest >> testCreation [

	self subject: LcsBasicSystem new.
	self assertCurrentSystemSetTo: LcsBasicSystem.
	self assertModuleConfigured: LcsSecurityModule.	
]
