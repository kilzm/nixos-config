import { bind, execAsync, Variable } from "astal";
import Category from "./Category";
import Item from "../Item";
import Icons from "../../../lib/icons";

function ShellCategory(query: Variable<string>) {
    const trimmed = bind(query).as(q => q.startsWith('>') ? q.slice(1).trim() : "")
    function execute() {
        execAsync(`ghostty -e '${trimmed.get()}; zsh'`)
    }

    const item = <Item
        cssClasses={["shell"]}
        iconName={Icons.ui.terminal}
        title={bind(trimmed)}
        onClicked={execute}
        canFocus={false}
    />

    return <Category 
        name={"Shell"}
        action={execute}
        child={item}
    />
}

export default ShellCategory
