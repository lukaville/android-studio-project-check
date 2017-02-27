package gradle

import com.android.tools.idea.gradle.GradleSyncState
import com.android.tools.idea.gradle.project.GradleProjectImporter
import com.android.tools.idea.gradle.project.GradleSyncListener
import com.intellij.openapi.project.Project

fun Project.sync(listener: (error: String?) -> Unit) {
    GradleSyncState.subscribe(this, object : GradleSyncListener {
        override fun syncFailed(project: Project, error: String) {
            println("Project sync failed")
            listener(error)
        }

        override fun syncStarted(project: Project) {
            println("Project sync started")
        }

        override fun syncSkipped(project: Project) {
            println("Project sync skipped")
            listener(null)
        }

        override fun syncSucceeded(project: Project) {
            println("Project sync succeeded")
            listener(null)
        }
    })
    GradleProjectImporter.getInstance().requestProjectSync(this, null)
}