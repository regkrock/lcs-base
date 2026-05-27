Class {
	#name : 'LcsCompenentAttributeBuilderJobExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-BaseTests-Examples',
	#package : 'Lcs-BaseTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsCompenentAttributeBuilderJobExamples >> componentAttributeBuilderJob [
	<gtExample>
	| builderJob |
	builderJob := self newBuilderJob.
	builderJob
		classPrefix: 'Lui';
		createForRootName: 'Level';
		installNewClassesInPackageNamed: 'Lcs-WebComponents' tag: 'Core'.
	self assert: builderJob classPrefix equals: 'Lui'.
	self assert: builderJob targetPackageName equals: 'Lcs-WebComponents'.
	self assert: builderJob targetPackageTagName equals: 'Core'.
	builderJob buildJobSteps.
	^ builderJob
]

{ #category : 'examples' }
LcsCompenentAttributeBuilderJobExamples >> newBuilderJob [
	<gtExample>
	| builderJob |
	builderJob := LcsCompenentAttributeBuilderJob new.
	self assert: builderJob class equals: LcsCompenentAttributeBuilderJob.
	^ builderJob
]
